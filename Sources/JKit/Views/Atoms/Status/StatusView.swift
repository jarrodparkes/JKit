import UIKit

// MARK: - StatusViewDisplayable

/// An object that can be displayed by a `StatusViews`.
public protocol StatusViewDisplayable {
    /// The status string.
    var status: String { get }

    /// The status type.
    var type: StatusType { get }
}

// MARK: - StatusView: BaseView

public class StatusView: BaseView {

    // MARK: Properties
    
    private let label = UILabel(frame: .zero)
    private var height: NSLayoutConstraint?

    public override var visualConstraintViews: [String: AnyObject] {
        return [
            "label": label
        ]
    }

    public override var visualConstraints: [String] {
        return [
            "H:|[label]|",
            "V:|-8-[label]-8-|"
        ]
    }

    // MARK: BaseView

    public override func addSubviews() {
        addSubview(label)
    }

    // MARK: Custom Styling

    public func styleWith(theme: Theme, displayable: StatusViewDisplayable) {
        let colors = theme.colors
        let constants = theme.constants

        if height == nil {
            height = label.heightAnchor.constraint(equalToConstant: constants.statusViewHeight)
            if let height = height {
                NSLayoutConstraint.activate([height])
            }
        }
        
        let backgroundColor = displayable.type.color(colors: colors)
        label.backgroundColor = backgroundColor
        label.layer.borderColor = backgroundColor.cgColor
        label.layer.cornerRadius = constants.statusViewCornerRadius
        label.layer.masksToBounds = true

        label.numberOfLines = 0
        label.attributedText = displayable.status.uppercased()
            .attributed(fontStyle: .caption, color: displayable.type.textColor(colors: colors), alignment: .center)
    }
}
