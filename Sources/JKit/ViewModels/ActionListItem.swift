import UIKit

// MARK: - ActionListItem: ActionListCellDisplayable

public struct ActionListItem: ActionListCellDisplayable {

    // MARK: Properties

    let identifier = UUID()
    
    public let icon: UIImage?
    public let title: String
    public let subtitle: String?
    public let accessoryStyle: ActionListAccessoryViews

    private let customIconTintColor: UIColor?
    private let customTitleTextColor: UIColor?
    private let customBackgroundColor: UIColor?

    // MARK: Initializer

    public init(icon: UIImage?,
                title: String,
                subtitle: String?,
                accessoryStyle: ActionListAccessoryViews,
                customIconTintColor: UIColor? = nil,
                customTitleTextColor: UIColor? = nil,
                customBackgroundColor: UIColor? = nil) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.accessoryStyle = accessoryStyle
        self.customIconTintColor = customIconTintColor
        self.customTitleTextColor = customTitleTextColor
        self.customBackgroundColor = customBackgroundColor
    }

    public init(title: String,
                subtitle: String?,
                accessoryStyle: ActionListAccessoryViews,
                customTitleTextColor: UIColor? = nil,
                customBackgroundColor: UIColor? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.accessoryStyle = accessoryStyle
        self.customTitleTextColor = customTitleTextColor
        self.customBackgroundColor = customBackgroundColor

        self.icon = nil
        self.customIconTintColor = nil
    }

    public init(title: String,
                subtitle: String?,
                navigationStyle: ActionListNavigationStyle,
                customTitleTextColor: UIColor? = nil,
                customBackgroundColor: UIColor? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.accessoryStyle = .detailAndNavigation(nil, navigationStyle)
        self.customTitleTextColor = customTitleTextColor
        self.customBackgroundColor = customBackgroundColor

        self.icon = nil
        self.customIconTintColor = nil
    }

    public init(icon: UIImage?,
                title: String,
                navigationStyle: ActionListNavigationStyle,
                customIconTintColor: UIColor? = nil,
                customTitleTextColor: UIColor? = nil,
                customBackgroundColor: UIColor? = nil) {
        self.icon = icon
        self.title = title
        self.accessoryStyle = .detailAndNavigation(nil, navigationStyle)
        self.customIconTintColor = customIconTintColor
        self.customTitleTextColor = customTitleTextColor
        self.customBackgroundColor = customBackgroundColor

        self.subtitle = nil
    }
    
    // MARK: ActionListCellDisplayable
    
    public func customIconTintColor(colors: Colors) -> UIColor? {
        return customIconTintColor
    }
    
    public func customTitleTextColor(colors: Colors) -> UIColor? {
        return customTitleTextColor
    }
    
    public func customBackgroundColor(colors: Colors) -> UIColor? {
        return customBackgroundColor
    }
}

// MARK: - ActionListItem: Hashable

extension ActionListItem: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    public static func == (lhs: ActionListItem, rhs: ActionListItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
