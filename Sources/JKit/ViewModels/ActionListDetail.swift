import UIKit

// MARK: - ActionListDetail: ActionListDetailDisplayable

public struct ActionListDetail: ActionListDetailDisplayable {

    // MARK: Properties

    public let detail: String?
    private let customTextColor: UIColor?

    // MARK: Initializer

    public init(detail: String?, customTextColor: UIColor? = nil) {
        self.detail = detail
        self.customTextColor = customTextColor
    }
    
    // MARK: ActionListDetailDisplayable
    
    public func customTextColor(colors: Colors) -> UIColor? {
        return customTextColor
    }
}
