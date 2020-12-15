import UIKit

// MARK: - ColorsStandard: Colors, Bundlable

public struct ColorsStandard: Colors, Bundlable {

    // MARK: Action List

    public var tintActionListIcon: UIColor {
        return bundleColor(named: "TintActionListIcon", fallbackColor: .black)
    }

    // MARK: Alert View

    public var backgroundAlert: UIColor {
        return bundleColor(named: "BackgroundAlert", fallbackColor: .black)
    }
    public var colorAlertError: UIColor {
        return bundleColor(named: "ColorAlertError", fallbackColor: .red)
    }
    public var colorAlertInformation: UIColor {
        return bundleColor(named: "ColorAlertInformation", fallbackColor: .blue)
    }
    public var colorAlertSuccess: UIColor {
        return bundleColor(named: "ColorAlertSuccess", fallbackColor: .green)
    }
    public var tintAlertCloseButton: UIColor {
        return bundleColor(named: "TintAlertCloseButton", fallbackColor: .white)
    }

    // MARK: Bar Button Item

    public var backgroundButtonBarBadge: UIColor {
        return bundleColor(named: "BackgroundButtonBarBadge", fallbackColor: .red)
    }
    public var tintImageBarButtonItem: UIColor {
        return bundleColor(named: "TintImageBarButtonItem", fallbackColor: .black)
    }

    // MARK: Button

    public var tintButtonImagePrimary: UIColor {
        return bundleColor(named: "TintButtonImagePrimary", fallbackColor: .black)
    }
    public var tintButtonImageDisabled: UIColor {
        return bundleColor(named: "TintButtonImageDisabled", fallbackColor: .gray)
    }

    // MARK: Borders

    public var borderDisabled: UIColor {
        return bundleColor(named: "BorderDisabled", fallbackColor: .gray)
    }

    // MARK: Calendar

    public var backgroundCalendar: UIColor {
        return bundleColor(named: "BackgroundCalendar", fallbackColor: .white)
    }
    public var backgroundCalendarDayHighlighted: UIColor {
        return bundleColor(named: "BackgroundCalendarDayHighlighted", fallbackColor: .gray)
    }
    public var backgroundCalendarDayNeedsAttention: UIColor {
        return bundleColor(named: "BackgroundCalendarDayNeedsAttention", fallbackColor: .red)
    }
    public var backgroundCalendarDayNormal: UIColor {
        return bundleColor(named: "BackgroundCalendarDayNormal", fallbackColor: .black)
    }
    public var backgroundCalendarRangeBoundary: UIColor {
        return bundleColor(named: "BackgroundCalendarRangeBoundary", fallbackColor: .blue)
    }
    public var backgroundCalendarRangeBoundaryStart: UIColor {
        return bundleColor(named: "BackgroundCalendarRangeBoundaryStart", fallbackColor: .cyan)
    }
    public var backgroundCalendarRangeBoundaryInactive: UIColor {
        return bundleColor(named: "BackgroundCalendarRangeBoundaryInactive", fallbackColor: .purple)
    }
    public var tintCalendarButton: UIColor {
        return bundleColor(named: "TintCalendarButton", fallbackColor: .black)
    }

    // MARK: Cells

    public var backgroundCell: UIColor {
        return bundleColor(named: "BackgroundCell", fallbackColor: .white)
    }
    public var backgroundCellPressed: UIColor {
        return bundleColor(named: "BackgroundCellPressed", fallbackColor: .lightGray)
    }

    // MARK: Contained Button

    public var backgroundButtonContainedDisabled: UIColor {
        return bundleColor(named: "BackgroundButtonContainedDisabled", fallbackColor: .gray)
    }
    public var borderButtonContained: UIColor {
        return bundleColor(named: "BorderButtonContained", fallbackColor: .white)
    }

    // MARK: Footer

    public var backgroundFooter: UIColor {
        return bundleColor(named: "BackgroundFooter", fallbackColor: .white)
    }
    public var textFooterLabelLink: UIColor {
        return bundleColor(named: "TextFooterLabelLink", fallbackColor: .blue)
    }

    // MARK: General

    public var backgroundDivider: UIColor {
        return bundleColor(named: "BackgroundDivider", fallbackColor: .lightGray)
    }

    // MARK: Menu

    public var borderButtonMenu: UIColor {
        return bundleColor(named: "BorderButtonMenu", fallbackColor: .gray)
    }
    public var borderButtonMenuDisabled: UIColor {
        return bundleColor(named: "BorderButtonMenuDisabled", fallbackColor: UIColor.white.withAlphaComponent(0.6))
    }
    public var borderButtonMenuSelected: UIColor {
        return bundleColor(named: "BorderButtonMenuSelected", fallbackColor: .blue)
    }
    public var textButtonMenuPlaceholder: UIColor {
        return bundleColor(named: "TextButtonMenuPlaceholder", fallbackColor: .gray)
    }
    public var textButtonMenuSelected: UIColor {
        return bundleColor(named: "TextButtonMenuSelected", fallbackColor: .black)
    }

    // MARK: Menu Picker

    public var textMenuPickerRow: UIColor {
        return bundleColor(named: "TextMenuPickerRow", fallbackColor: .black)
    }

    // MARK: Notes

    public var backgroundNotes: UIColor {
        return bundleColor(named: "BackgroundNotes", fallbackColor: .lightGray)
    }
    public var textNotesLink: UIColor {
        return bundleColor(named: "TextNotesLink", fallbackColor: .blue)
    }

    // MARK: Selection Button

    public var backgroundSelectionButtonCheckbox: UIColor {
        return bundleColor(named: "BackgroundSelectionButtonCheckbox", fallbackColor: .black)
    }
    public var tintSelectionButtonCheckbox: UIColor {
        return bundleColor(named: "TintSelectionButtonCheckbox", fallbackColor: .white)
    }
    public var tintSelectionButtonPressed: UIColor {
        return bundleColor(named: "TintSelectionButtonPressed", fallbackColor: .lightGray)
    }
    public var tintSelectionButtonRadioInner: UIColor {
        return bundleColor(named: "TintSelectionButtonRadioInner", fallbackColor: .black)
    }
    public var tintSelectionButtonRadioOuter: UIColor {
        return bundleColor(named: "TintSelectionButtonRadioOuter", fallbackColor: .black)
    }

    // MARK: Status View

    public var backgroundStatusAlert: UIColor {
        return bundleColor(named: "BackgroundStatusAlert", fallbackColor: .red)
    }
    public var backgroundStatusInactive: UIColor {
        return bundleColor(named: "BackgroundStatusInactive", fallbackColor: .gray)
    }
    public var backgroundStatusNormal: UIColor {
        return bundleColor(named: "BackgroundStatusNormal", fallbackColor: .black)
    }
    public var backgroundStatusSuccess: UIColor {
        return bundleColor(named: "BackgroundStatusSuccess", fallbackColor: .green)
    }
    public var backgroundStatusWarning: UIColor {
        return bundleColor(named: "BackgroundStatusWarning", fallbackColor: .yellow)
    }
    public var textStatusAlert: UIColor {
        return bundleColor(named: "TextStatusAlert", fallbackColor: .black)
    }
    public var textStatusInactive: UIColor {
        return bundleColor(named: "TextStatusInactive", fallbackColor: .black)
    }
    public var textStatusNormal: UIColor {
        return bundleColor(named: "TextStatusNormal", fallbackColor: .white)
    }
    public var textStatusSuccess: UIColor {
        return bundleColor(named: "TextStatusSuccess", fallbackColor: .black)
    }
    public var textStatusWarning: UIColor {
        return bundleColor(named: "TextStatusWarning", fallbackColor: .black)
    }

    // MARK: Text

    public var textDisabled: UIColor {
        return bundleColor(named: "TextDisabled", fallbackColor: .gray)
    }
    public var textMediumEmphasis: UIColor {
        return bundleColor(named: "TextMediumEmphasis", fallbackColor: .darkGray)
    }
    public var textHighEmphasis: UIColor {
        return bundleColor(named: "TextHighEmphasis", fallbackColor: .black)
    }
    public var textHighEmphasisInverted: UIColor {
        return bundleColor(named: "TextHighEmphasisInverted", fallbackColor: .white)
    }
    public var textError: UIColor {
        return bundleColor(named: "TextError", fallbackColor: .red)
    }

    // MARK: Text Input

    public var colorTextInputNormal: UIColor {
        return bundleColor(named: "ColorTextInputNormal", fallbackColor: .gray)
    }
    public var colorTextInputError: UIColor {
        return bundleColor(named: "ColorTextInputError", fallbackColor: .red)
    }
    public var colorTextInputSelected: UIColor {
        return bundleColor(named: "ColorTextInputSelected", fallbackColor: .blue)
    }
    public var textInputPlaceholder: UIColor {
        return bundleColor(named: "TextInputPlaceholder", fallbackColor: .gray)
    }
    public var textInputTip: UIColor {
        return bundleColor(named: "TextInputTip", fallbackColor: .gray)
    }
    public var tintTextInputCursor: UIColor {
        return bundleColor(named: "TintTextInputCursor", fallbackColor: .black)
    }
    public var tintTextInputIcon: UIColor {
        return bundleColor(named: "TintTextInputIcon", fallbackColor: .gray)
    }

    // MARK: Initializer

    public init() {}

    // MARK: Helpers

    func bundleColor(named: String, fallbackColor: UIColor) -> UIColor {
        return UIColor(named: named, in: ColorsStandard.bundle, compatibleWith: nil) ?? fallbackColor
    }
}
