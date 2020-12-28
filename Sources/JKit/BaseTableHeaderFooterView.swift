import UIKit

// MARK: - BaseTableHeaderFooterView: UITableViewHeaderFooterView, BaseUIConfigurable

/// A `UITableViewHeaderFooterView` with known injection points for visually formatted Auto Layout constraints,
/// adding subviews, and adding subview targets/actions.
open class BaseTableHeaderFooterView: UITableViewHeaderFooterView, BaseUIConfigurable {

    // MARK: Properties

    var theme: Theme?

    open var visualConstraintViews: [String: AnyObject] { return [:] }
    open var visualConstraints: [String] { return [] }

    // MARK: Initializer

    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addSubviews()
        setVisualConstraints()
        addTargets()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Style

    open func styleWith(theme: Theme) {}
    open func styleEnabled(theme: Theme, enabled: Bool) {}

    // MARK: BaseUIConfigurable

    open func addSubviews() {}

    final public func setVisualConstraints() {
        addVisualConstraints(visualConstraintViews: visualConstraintViews, visualConstraints: visualConstraints)
    }

    open func addTargets() {}
}
