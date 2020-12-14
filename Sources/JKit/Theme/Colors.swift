import UIKit

// MARK: - Colors

/// An object that defines all the colors for JKit.
public protocol Colors {

    // MARK: Action List

    /// Tint color for action list icons.
    var tintActionListIcon: UIColor { get }

    // MARK: Alert View

    /// Background color for `AlertView`.
    var backgroundAlert: UIColor { get }
    /// Alert View - Error color.
    var colorAlertError: UIColor { get }
    /// Alert View - Information color.
    var colorAlertInformation: UIColor { get }
    /// Alert View - Success color.
    var colorAlertSuccess: UIColor { get }
    /// Tint color for close button in an `AlertView`.
    var tintAlertCloseButton: UIColor { get }

    // MARK: Bar Button Item

    /// Background color for `UIBarButtonItem` badges.
    var backgroundButtonBarBadge: UIColor { get }
    /// Tint color for the image in a `UIBarButtonItem`.
    var tintImageBarButtonItem: UIColor { get }

    // MARK: Button

    /// Primary tint color for an image in a `UIButton`.
    var tintButtonImagePrimary: UIColor { get }
    /// Disabled tint color for an image in a `UIButton`.
    var tintButtonImageDisabled: UIColor { get }

    // MARK: Borders

    /// Standard border color.
    var borderDisabled: UIColor { get }

    // MARK: Calendar

    /// Background color for calendar.
    var backgroundCalendar: UIColor { get }
    /// Background color for a calendar day that is highlighted.
    var backgroundCalendarDayHighlighted: UIColor { get }
    /// Background color for a calendar day that needs attention.
    var backgroundCalendarDayNeedsAttention: UIColor { get }
    /// Background color for a calendar day that has normal status.
    var backgroundCalendarDayNormal: UIColor { get }
    /// Background color for a range boundary in a `HCalendarView`.
    var backgroundCalendarRangeBoundary: UIColor { get }
    /// Background color for a starting range boundary in a `HCalendarView`.
    var backgroundCalendarRangeBoundaryStart: UIColor { get }
    /// Background color for an inactive range boundary in a `HCalendarView`.
    var backgroundCalendarRangeBoundaryInactive: UIColor { get }
    /// Tint color for buttons in a `HCalendarView`.
    var tintCalendarButton: UIColor { get }

    // MARK: Cells

    /// Background color for table cells.
    var backgroundCell: UIColor { get }
    /// Background color when table cell is pressed.
    var backgroundCellPressed: UIColor { get }

    // MARK: Contained Button

    /// Contained Button - Disabled background color.
    var backgroundButtonContainedDisabled: UIColor { get }
    /// Contained Button - Border color.
    var borderButtonContained: UIColor { get }

    // MARK: Footer

    /// Background color for `Footer`.
    var backgroundFooter: UIColor { get }
    /// Text color for `Footer` label when it is a tappable link.
    var textFooterLabelLink: UIColor { get }

    // MARK: General

    /// Background color for divider lines.
    var backgroundDivider: UIColor { get }

    // MARK: Menu

    /// Border color used for the button contained within a `Menu`.
    var borderButtonMenu: UIColor { get }
    /// Border color used for the button contained within a `Menu` when it is disabled.
    var borderButtonMenuDisabled: UIColor { get }
    /// Border color used for the button contained within a `Menu` when it is selected.
    var borderButtonMenuSelected: UIColor { get }
    /// Text color for the button contained within a `Menu` when a placeholder value is used.
    var textButtonMenuPlaceholder: UIColor { get }
    /// Text color for the button contained within a `Menu` when a value has been selected.
    var textButtonMenuSelected: UIColor { get }

    // MARK: Menu Picker

    /// Text color for `MenuPicker` rows.
    var textMenuPickerRow: UIColor { get }

    // MARK: Notes

    /// Background color for `NotesView`.
    var backgroundNotes: UIColor { get }
    /// Text color for links contained within a `NotesView`.
    var textNotesLink: UIColor { get }

    // MARK: Selection Button

    /// Background color for checkboxes.
    var backgroundSelectionButtonCheckbox: UIColor { get }
    /// Tint color for checkboxes.
    var tintSelectionButtonCheckbox: UIColor { get }
    /// Tint color for when a selection button is pressed.
    var tintSelectionButtonPressed: UIColor { get }
    /// Tint color for radio buttons.
    var tintSelectionButtonRadio: UIColor { get }

    // MARK: Status View
    
    /// Status View - Alert background color.
    var backgroundStatusAlert: UIColor { get }
    /// Status View - Inactive background color.
    var backgroundStatusInactive: UIColor { get }
    /// Status View - Normal background color.
    var backgroundStatusNormal: UIColor { get }
    /// Status View - Success background color.
    var backgroundStatusSuccess: UIColor { get }
    /// Status View - Warning background color.
    var backgroundStatusWarning: UIColor { get }
    /// Status View - Alert text color.
    var textStatusAlert: UIColor { get }
    /// Status View - Inactive text color.
    var textStatusInactive: UIColor { get }
    /// Status View - Normal text color.
    var textStatusNormal: UIColor { get }
    /// Status View - Success text color.
    var textStatusSuccess: UIColor { get }
    /// Status View - Warning text color.
    var textStatusWarning: UIColor { get }
    
    // MARK: Text

    /// Disabled text color.
    var textDisabled: UIColor { get }
    /// Medium emphasis text color.
    var textMediumEmphasis: UIColor { get }
    /// High emphasis text color.
    var textHighEmphasis: UIColor { get }
    /// Inverted high emphasis text color.
    var textHighEmphasisInverted: UIColor { get }
    /// Error text color.
    var textError: UIColor { get }

    // MARK: Text Input

    /// Color for `TextInput` underline or border.
    var colorTextInputNormal: UIColor { get }
    /// Color for `TextInput` underline or border when `TextInput` has an error.
    var colorTextInputError: UIColor { get }
    /// Color for `TextInput` underline or border when `TextInput` is selected.
    var colorTextInputSelected: UIColor { get }
    /// Text color for `TextInput` placeholder.
    var textInputPlaceholder: UIColor { get }
    /// Text color for `TextInput` tip.
    var textInputTip: UIColor { get }
    /// Tint color for `TextInput` cursor.
    var tintTextInputCursor: UIColor { get }
    /// Tint color for `TextInput` icons.
    var tintTextInputIcon: UIColor { get }
}
