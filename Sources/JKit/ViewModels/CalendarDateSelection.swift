import Foundation
import HorizonCalendar

// MARK: - CalendarDateSelection

/// A selection on a `HCalendarView` specified as `Date` objects.
public enum CalendarDateSelection {
    /// A single date.
    case singleDate(Date?)
    /// Multiple dates.
    case multiDate([Date])
    /// A date range.
    case singleRange(CalendarPartialDateSelection, ClosedRange<Date>?)
    /// Multiple date ranges.
    case multiRange(CalendarPartialDateSelection, [ClosedRange<Date>])
    /// No selection. View only.
    case none

    // MARK: Properties

    var allowActiveRangeDeletion: Bool {
        if case let .multiRange(partial, _) = self, case .fullRange = partial {
            return true
        }

        return false
    }

    // MARK: Style

    func styleForDate(_ date: Date, calendar: Calendar) -> CalendarDayViewSelectionStyle {
        switch self {
        case .singleDate(let selectedDate):
            return (date == selectedDate) ? .singleSelect : .none
        case .multiDate(let selectedDates):
            return (selectedDates.contains(date)) ? .singleSelect : .none
        case .singleRange(let partial, let range):
            if let range = range {
                if (date == range.lowerBound) || (date == range.upperBound) {
                    return .activeRangeBoundary
                }
            }
            return partial.styleForDate(date, calendar: calendar) ?? .none
        case .multiRange(let partial, let ranges):
            if let style = partial.styleForDate(date, calendar: calendar) {
                return style
            }

            for range in ranges {
                if (date == range.lowerBound) || (date == range.upperBound) {
                    return .inactiveRangeBoundary
                }
            }

            return .none
        case .none:
            return .none
        }
    }

    // MARK: Helpers

    func activeRange(calendar: Calendar) -> ClosedRange<Date>? {
        switch self {
        case .singleDate, .multiDate, .none:
            return nil
        case .singleRange(let partial, _), .multiRange(let partial, _):
            if case let .fullRange(range) = partial {
                return range
            } else {
                return nil
            }
        }
    }

    func allRanges(calendar: Calendar) -> Set<ClosedRange<Date>> {
        switch self {
        case .singleDate, .multiDate, .none:
            return []
        case .singleRange(_, let range):
            if let range = range {
                return [range]
            } else {
                return []
            }
        case .multiRange(_, let ranges):
            var allRanges = Set<ClosedRange<Date>>()
            for range in ranges {
                allRanges.insert(range)
            }
            return allRanges
        }
    }

    // MARK: Compute Next Selection

    func computeNextSelection(newlySelectedDay day: Day, calendar: Calendar) -> CalendarDateSelection {
        guard let date = day.date(calendar: calendar) else { return .none }

        switch self {
        case .singleDate:
            return .singleDate(date)
        case .multiDate(let previouslySelectedDates):
            return computeNextMultipleDatesSelection(newlySelectedDate: date,
                                                     previouslySelectedDates: previouslySelectedDates)
        case .singleRange(let partial, _):
            return computeNextSingleRangeSelection(newlySelectedDate: date, partial: partial)
        case .multiRange(let partial, let ranges):
            return computeNextMultiRangeSelection(newlySelectedDate: date,
                                                  calendar: calendar,
                                                  partial: partial,
                                                  ranges: ranges)
        case .none:
            return .none
        }
    }

    private func computeNextMultipleDatesSelection(newlySelectedDate date: Date,
                                                   previouslySelectedDates: [Date]) -> CalendarDateSelection {
        if previouslySelectedDates.contains(date) {
            return .multiDate(previouslySelectedDates.filter { $0 != date })
        } else {
            return .multiDate(previouslySelectedDates + [date])
        }
    }

    private func computeNextSingleRangeSelection(newlySelectedDate date: Date,
                                                 partial: CalendarPartialDateSelection) -> CalendarDateSelection {
        switch partial {
        case .none:
            return .singleRange(.startRange(date), nil)
        case .fullRange:
            return .singleRange(.startRange(date), nil)
        case .startRange(let partialDate):
            let nextRange = computeNextRange(selectedDate: date, partialDate: partialDate)
            return .singleRange(.fullRange(nextRange), nextRange)
        }
    }

    private func computeNextMultiRangeSelection(newlySelectedDate date: Date,
                                                calendar: Calendar,
                                                partial: CalendarPartialDateSelection,
                                                ranges: [ClosedRange<Date>]) -> CalendarDateSelection {
        switch partial {
        case .none:
            if let range = dayInExistingRange(date, calendar: calendar, ranges: ranges) {
                return .multiRange(.fullRange(range), ranges)
            } else {
                return .multiRange(.startRange(date), ranges)
            }
        case .fullRange(let currentRange):
            if currentRange.contains(date) {
                return .multiRange(.none, ranges)
            } else if let range = dayInExistingRange(date, calendar: calendar, ranges: ranges) {
                return .multiRange(.fullRange(range), ranges)
            } else {
                return .multiRange(.startRange(date), ranges)
            }
        case .startRange(let partialDate):
            var nextRange = computeNextRange(selectedDate: date, partialDate: partialDate)
            var mutableRanges = ranges

            while let index = findOverlap(nextRange: nextRange, ranges: mutableRanges, calendar: calendar) {
                let intersectingRange = mutableRanges.remove(at: index)
                let newLowerBound = min(nextRange.lowerBound, intersectingRange.lowerBound)
                let newUpperBound = max(nextRange.upperBound, intersectingRange.upperBound)
                nextRange = newLowerBound...newUpperBound
            }

            return .multiRange(.fullRange(nextRange), mutableRanges + [nextRange])
        }
    }

    private func computeNextRange(selectedDate day: Date, partialDate: Date) -> ClosedRange<Date> {
        if partialDate > day {
            return day...partialDate
        } else if partialDate == day {
            return day...day
        } else {
            return partialDate...day
        }
    }

    private func findOverlap(nextRange: ClosedRange<Date>, ranges: [ClosedRange<Date>], calendar: Calendar) -> Int? {
        let dateRanges = ranges.compactMap { $0 }

        for (index, dateRange) in dateRanges.enumerated() {
            if nextRange.overlaps(dateRange) { return index }
        }
        return nil
    }

    private func dayInExistingRange(_ date: Date,
                                    calendar: Calendar,
                                    ranges: [ClosedRange<Date>]) -> ClosedRange<Date>? {
        for range in ranges {
            if range.contains(date) { return range }
        }
        return nil
    }
}

// MARK: - CalendarPartialDateSelection

/// A partial selection on a `HCalendarView`.
public enum CalendarPartialDateSelection {
    /// A partial range selection consisting of one bound.
    case startRange(Date)
    /// A full range selection.
    case fullRange(ClosedRange<Date>)
    /// No selection.
    case none

    // MARK: Helpers

    func styleForDate(_ date: Date, calendar: Calendar) -> CalendarDayViewSelectionStyle? {
        switch self {
        case .startRange(let partialDate):
            return (date == partialDate) ? .startRangeBoundary : nil
        case .fullRange(let range):
            return (date == range.lowerBound) || (date == range.upperBound) ? .activeRangeBoundary : nil
        default:
            return nil
        }
    }
}
