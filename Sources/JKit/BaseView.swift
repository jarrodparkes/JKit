import UIKit

// MARK: - BaseView: UIView, BaseUIConfigurable

/// A `UIView` with known injection points for visually formatted Auto Layout constraints,
/// adding subviews, and adding subview targets/actions.
open class BaseView: UIView, BaseUIConfigurable {

    // MARK: Properties

    open var visualConstraintViews: [String: AnyObject] { return [:] }
    open var visualConstraints: [String] { return [] }

    // MARK: Initializer

    public override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setVisualConstraints()
        addTargets()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: BaseUIConfigurable

    open func addSubviews() {}

    final public func setVisualConstraints() {
        addVisualConstraints(visualConstraintViews: visualConstraintViews, visualConstraints: visualConstraints)
    }

    open func addTargets() {}
}
