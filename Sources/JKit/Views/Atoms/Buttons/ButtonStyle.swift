import UIKit

// MARK: - ButtonStyle

/// A type of styling that can be applied to a `Button`.
public enum ButtonStyle {
    /// A button style that displays text on an opaque background.
    case contained(UIColor?, UIColor?)
    /// A button style that displays a menu's selection or placeholder value.
    case menu
    /// A button style that displays text and a rounded border.
    case outline(UIColor?, UIColor?)
    /// A button style that displays text similar to a label and specifies the content's horizontal layout.
    case text(UIColor?, UIControl.ContentHorizontalAlignment)
}
