import UIKit

// MARK: - Button: UIButton

public class Button: UIButton {
    
    // MARK: Properties
    
    private var style: ButtonStyle
    private var theme: Theme?
    private var height: NSLayoutConstraint?
    
    internal var customSubView: UIView?
    
    // MARK: Initializer
    
    public init(frame: CGRect, style: ButtonStyle) {
        self.style = style
        super.init(frame: frame)
    }
    
    internal override init(frame: CGRect) {
        style = .contained(nil, nil)
        super.init(frame: frame)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        style = .contained(nil, nil)
        super.init(coder: aDecoder)
    }
    
    // MARK: UIButton
    
    public override var isEnabled: Bool {
        didSet {
            styleEnabled()
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            if let theme = theme {
                let constants = theme.constants
                alpha = isHighlighted ? constants.alphaDisabled : 1.0
            }
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            if let theme = theme {
                let colors = theme.colors
                
                switch style {
                case .contained(_, let containedColor):
                    // underline
                    let attributes: [NSAttributedString.Key: Any] = isSelected ? FontStyle.attributesUnderline() : [:]
                    titleLabel?.attributedText = NSAttributedString(string: currentTitle ?? "",
                                                                    attributes: attributes)
                    
                    // inner border
                    customSubView?.isHidden = !isSelected
                    customSubView?.layer.borderColor = containedColor?.cgColor
                case .menu:
                    let borderColor = isSelected ? colors.borderButtonMenuSelected : colors.borderButtonMenu
                    layer.borderColor = borderColor.cgColor
                case .outline:
                    // underline
                    let attributes: [NSAttributedString.Key: Any] = isSelected ? FontStyle.attributesUnderline() : [:]
                    titleLabel?.attributedText = NSAttributedString(string: currentTitle ?? "",
                                                                    attributes: attributes)
                    
                    // inner border
                    customSubView?.isHidden = !isSelected
                case .text:
                    // underline
                    let attributes: [NSAttributedString.Key: Any] = isSelected ? FontStyle.attributesUnderline() : [:]
                    titleLabel?.attributedText = NSAttributedString(string: currentTitle ?? "",
                                                                    attributes: attributes)
                }
            }
        }
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        guard let theme = theme else { return }
        
        styleEnabled()
        styleBorder(theme: theme)
        
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    // MARK: Style
    
    public func styleWith(theme: Theme, style: ButtonStyle) {
        var canSwapStyle = false
        switch self.style {
        case .contained:
            if case .contained = style { canSwapStyle = true }
        case .menu:
            if case .menu = style { canSwapStyle = true }
        case .outline:
            if case .outline = style { canSwapStyle = true }
        case .text:
            if case .text = style { canSwapStyle = true }
        }
        
        if canSwapStyle {
            self.style = style
            styleWith(theme: theme)
        }
    }
    
    public func styleWith(theme: Theme) {
        self.theme = theme
        
        if height == nil {
            height = heightAnchor.constraint(equalToConstant: theme.constants.buttonHeight)
            if let height = height {
                NSLayoutConstraint.activate([height])
            }
        }
        
        styleContentAlignment(theme: theme)
        styleContentEdgeInsets(theme: theme)
        styleEnabled(theme: theme, enabled: isEnabled)
        styleFontStyle(theme: theme)
        styleTitleColor(theme: theme)
        styleBorder(theme: theme)
        styleCornerRadius(theme: theme)
        
        if let customSubView = customSubView {
            addSubview(customSubView)
        }
    }
    
    private func styleContentAlignment(theme: Theme) {
        let constants = theme.constants
        
        switch style {
        case .menu:
            titleEdgeInsets = constants.menuButtonTitleEdgeInsets
            contentHorizontalAlignment = .left
        case .text(_, let contentHorizontalAlignment):
            self.contentHorizontalAlignment = contentHorizontalAlignment
        default: return
        }
    }
    
    private func styleContentEdgeInsets(theme: Theme) {
        let constants = theme.constants
        
        switch style {
        case .contained, .outline:
            contentEdgeInsets = constants.buttonContentEdgeInsets
        default: return
        }
    }
    
    private func styleEnabled() {
        if let theme = theme {
            styleEnabled(theme: theme, enabled: isEnabled)
        }
    }
    
    private func styleEnabled(theme: Theme, enabled: Bool) {
        let colors = theme.colors
        let constants = theme.constants
        
        switch style {
        case .contained(_, let containedColor):
            backgroundColor = enabled ? containedColor : colors.backgroundButtonContainedDisabled
        case .menu:
            alpha = enabled ? 1.0 : constants.alphaDisabled
            layer.borderColor = enabled ? colors.borderButtonMenu.cgColor : colors.borderButtonMenuDisabled.cgColor
        case .outline(_, let outlineColor):
            let borderColor = outlineColor ?? .clear
            layer.borderColor = (enabled ? borderColor : colors.borderDisabled).cgColor            
        case .text: return
        }
    }
    
    private func styleFontStyle(theme: Theme) {
        let constants = theme.constants
        
        switch style {
        case .menu: titleLabel?.font = FontStyle.body.font
        case .text: titleLabel?.font = FontStyle.label.font
        default: titleLabel?.font = FontStyle.h4.font
        }
        
        switch style {
        case .menu:
            titleLabel?.numberOfLines = 2
            titleLabel?.lineBreakMode = .byTruncatingTail
        case .text:
            titleLabel?.numberOfLines = 0
        default:
            titleLabel?.adjustsFontSizeToFitWidth = true
            titleLabel?.minimumScaleFactor = constants.buttonTextMinimumScaleFactor
        }
    }
    
    private func styleTitleColor(theme: Theme) {
        let colors = theme.colors
        
        var titleColor: UIColor
        switch style {
        case .contained(let textColor, _), .outline(let textColor, _), .text(let textColor, _):
            titleColor = textColor ?? colors.textHighEmphasis
        case .menu:
            titleColor = colors.textButtonMenuPlaceholder
        }
        
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor, for: .highlighted)
        setTitleColor(titleColor, for: .selected)
        setTitleColor(colors.textDisabled, for: .disabled)
    }
    
    private func styleBorder(theme: Theme) {
        let colors = theme.colors
        let constants = theme.constants
        
        switch style {
        case .menu:
            layer.borderWidth = constants.buttonBorderWidth
            layer.borderColor = colors.borderButtonMenu.cgColor
        case .outline(_, let outlineColor):
            layer.borderWidth = constants.buttonBorderWidth
            layer.borderColor = outlineColor?.cgColor
        case .contained:
            let offset: CGFloat = constants.buttonContainedInnerBorderInset
            let padding = offset * 2.0
            let innerBorderView = UIView(frame: CGRect(x: offset,
                                                       y: offset,
                                                       width: frame.size.width - padding,
                                                       height: frame.size.height - padding))
            
            innerBorderView.backgroundColor = .clear
            innerBorderView.layer.borderWidth = constants.buttonBorderWidth
            innerBorderView.layer.borderColor = colors.borderButtonContained.cgColor
            innerBorderView.layer.cornerRadius = constants.buttonCornerRadiusStandard
            innerBorderView.isHidden = true
            customSubView = innerBorderView
        case .text: return
        }
    }
    
    private func styleCornerRadius(theme: Theme) {
        let constants = theme.constants
        
        switch style {
        case .menu:
            layer.cornerRadius = constants.buttonCornerRadiusSmall
        case .outline, .contained:
            layer.cornerRadius = constants.buttonCornerRadiusStandard
        case .text: return
        }
    }
}
