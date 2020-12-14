import UIKit

// MARK: - StatusType

/// Describes the state of something.
public enum StatusType {
    /// Selected status.
    case selected
    /// Alert status.
    case alert
    /// Normal status.
    case normal
    /// Success status.
    case success
    /// Warning status.
    case warning
    /// Inactive status.
    case inactive

    // MARK: Properties

    /// Returns the color to use for this `StatusType`.
    /// - Parameter colors: An object that defines all the colors for JKit.
    /// - Returns: The color for this `StatusType`.
    public func color(colors: Colors) -> UIColor {
        switch self {
        case .alert: return colors.backgroundStatusAlert
        case .normal, .selected: return colors.backgroundStatusNormal
        case .success: return colors.backgroundStatusSuccess
        case .warning: return colors.backgroundStatusWarning
        case .inactive: return colors.backgroundStatusInactive
        }
    }

    /// Returns the text color to use for this `StatusType`.
    /// - Parameter colors: An object that defines all the colors for JKit.
    /// - Returns: The text color for this `StatusType`.
    public func textColor(colors: Colors) -> UIColor {
        switch self {
        case .alert: return colors.textStatusAlert
        case .normal, .selected: return colors.textStatusNormal
        case .success: return colors.textStatusSuccess
        case .warning: return colors.textStatusWarning
        case .inactive: return colors.textStatusInactive        
        }
    }
}
