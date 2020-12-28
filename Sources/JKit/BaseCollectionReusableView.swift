import UIKit

// MARK: - BaseCollectionReusableView: UICollectionReusableView, BaseUIConfigurable

/// A `UICollectionReusableView` with known injection points for visually formatted Auto Layout constraints,
/// adding subviews, and adding subview targets/actions.
open class BaseCollectionReusableView: UICollectionReusableView, BaseUIConfigurable {
    
    // MARK: Properties
    
    var theme: Theme?
    
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
        super.init(coder: aDecoder)
        
        addSubviews()
        setVisualConstraints()
        addTargets()
    }
    
    // MARK: Style
    
    open func styleWith(theme: Theme) {
        self.theme = theme
        
        let colors = theme.colors
        
        backgroundColor = colors.backgroundCell
    }
    
    open func styleEnabled(theme: Theme, enabled: Bool) {
        let constants = theme.constants
        alpha = enabled ? 1.0 : constants.alphaDisabled
    }
    
    // MARK: BaseUIConfigurable
    
    open func addSubviews() {}
    
    final public func setVisualConstraints() {
        addVisualConstraints(visualConstraintViews: visualConstraintViews, visualConstraints: visualConstraints)
    }
    
    open func addTargets() {}
}
