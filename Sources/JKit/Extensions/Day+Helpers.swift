import Foundation
import HorizonCalendar

// MARK: - Day (Helpers)

extension Day {
    func date(calendar: Calendar) -> Date? {
        if let date = calendar.date(from: components) {
            return calendar.trimTimeFromDate(date)
        }
        return nil
    }
}
