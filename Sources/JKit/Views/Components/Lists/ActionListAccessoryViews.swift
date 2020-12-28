import UIKit

// MARK: - ActionListDetailDisplayable

/// An object that can be displayed by the detail label in a `ActionListCell`.
public protocol ActionListDetailDisplayable {
    /// The detail to display.
    var detail: String? { get }

    /// A custom text color for the detail.
    func customTextColor(colors: Colors) -> UIColor?
}

// MARK: - ActionListAccessoryViews

/// Describes the accessory views for a `ActionListCell`.
public enum ActionListAccessoryViews {
    /// A style showing only a detail label.
    case detailOnly(ActionListDetailDisplayable?)
    /// A style showing a detail label and navigation icon.
    case detailAndNavigation(ActionListDetailDisplayable?, ActionListNavigationStyle)
    /// A style showing no accessory views.
    case none

    // MARK: Properties

    /// The detail associated with these views.
    public var detailDisplayable: ActionListDetailDisplayable? {
        switch self {
        case .detailOnly(let detailDisplayable),
             .detailAndNavigation(let detailDisplayable, _):
            return detailDisplayable
        case .none: return nil
        }
    }

    // MARK: Helpers

    /// Returns the total width to use for the accessory views.
    /// - Parameter constants: An object that defines all the constants for JKit.
    /// - Returns: The total width to use for the accessory views.
    public func totalWidth(constants: Constants) -> CGFloat {
        switch self {
        case .none: return 0        
        default: return (detailDisplayable?.detail == nil)
            ? constants.actionListAccessoryImageSize.width
            : constants.actionListAccessoryDetailAndImageWidth
        }
    }
}
