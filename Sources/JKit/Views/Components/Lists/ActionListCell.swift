import UIKit

// MARK: - ActionListCellDisplayable

/// An object that can be displayed by a `ActionListCell`.
public protocol ActionListCellDisplayable {
    /// The icon displayed alongside the title and subtitle in the cell.
    var icon: UIImage? { get }

    /// The title displayed in the cell.
    var title: String { get }

    /// The subtitle displayed in the cell.
    var subtitle: String? { get }

    /// The style of the accessory view for the cell.
    var accessoryStyle: ActionListAccessoryViews { get }

    /// A custom tint color to apply to the icon.
    func customIconTintColor(colors: Colors) -> UIColor?

    /// A custom text color to apply to the title.
    func customTitleTextColor(colors: Colors) -> UIColor?

    /// A custom background color to apply to the cell.
    func customBackgroundColor(colors: Colors) -> UIColor?
}

// MARK: - ActionListCell: BaseTableViewCell

public class ActionListCell: BaseTableViewCell {

    // MARK: Properties

    var accessoryStatusView: StatusView?
    var accessoryDetailLabel: UILabel?
    var accessoryImageView: UIImageView?

    var accessoryStackView: UIStackView?

    // MARK: Initializer

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    // MARK: Style

    public func styleWith(theme: Theme, displayable: ActionListCellDisplayable) {
        super.styleWith(theme: theme)
        
        if (accessoryView as? UIStackView) == nil {
            addAccessoryViews(theme: theme)
        }
        
        let colors = theme.colors
        let constants = theme.constants
        let textColor = colors.textHighEmphasis

        // adjust frame based on accessory style
        if let previousAccessoryFrame = accessoryView?.frame {
            accessoryView?.frame = CGRect(x: 0,
                                          y: 0,
                                          width: displayable.accessoryStyle.totalWidth(constants: constants),
                                          height: previousAccessoryFrame.height)
        }

        // background
        backgroundColor = displayable.customBackgroundColor(colors: colors) ?? colors.backgroundCell

        // icon
        imageView?.image = displayable.icon
        imageView?.tintColor = displayable.customIconTintColor(colors: colors) ?? colors.tintActionListIcon

        // title
        let titleTextColor = displayable.customTitleTextColor(colors: colors) ?? textColor
        textLabel?.numberOfLines = 0
        textLabel?.attributedText = displayable.title.attributed(fontStyle: .label, color: titleTextColor)

        // subtitle
        let subtitle = displayable.subtitle ?? ""
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.attributedText = subtitle.attributed(fontStyle: .body, color: textColor)

        // detail
        let detailDisplayable = displayable.accessoryStyle.detailDisplayable
        let detailString = detailDisplayable?.detail ?? ""
        let detailTextColor = detailDisplayable?.customTextColor(colors: colors) ?? textColor
        accessoryDetailLabel?.attributedText = detailString.attributed(fontStyle: .body,
                                                                       color: detailTextColor,
                                                                       alignment: .right)

        // acccessory views
        styleAccessoryViews(theme: theme)
        
        accessoryDetailLabel?.isHidden = detailString.isEmpty
        switch displayable.accessoryStyle {
        case .detailOnly:
            accessoryStatusView?.isHidden = true
            accessoryImageView?.isHidden = true
            accessoryView = detailString.isEmpty ? nil : accessoryStackView
        case .detailAndNavigation(_, let navigationStyle):
            accessoryStatusView?.isHidden = true
            accessoryImageView?.isHidden = false
            accessoryImageView?.image = navigationStyle.icon(images: theme.images)
            accessoryView = (detailString.isEmpty && navigationStyle == .none) ? nil : accessoryStackView
        case .statusAndDetail(let displayable, _):
            accessoryStatusView?.isHidden = false
            accessoryImageView?.isHidden = true
            accessoryStatusView?.styleWith(theme: theme, displayable: displayable)
            accessoryView = accessoryStackView
        case .none:
            accessoryView = nil
        }
    }
    
    private func addAccessoryViews(theme: Theme) {
        let constants = theme.constants
        let imageSize = constants.actionListAccessoryImageSize
        
        accessoryStatusView = StatusView(frame: .zero)
        accessoryDetailLabel = UILabel(frame: .zero)
        accessoryImageView = UIImageView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: imageSize.width,
                                                       height: imageSize.height))
        
        accessoryStackView = UIStackView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: constants.actionListAccessoryDetailAndImageWidth,
                                                       height: frame.height))
        
        accessoryStackView?.addArrangedSubview(accessoryStatusView ?? StatusView())
        accessoryStackView?.addArrangedSubview(accessoryDetailLabel ?? UILabel())
        accessoryStackView?.addArrangedSubview(accessoryImageView ?? UIImageView())
        
        if let detailWidthMininum = accessoryDetailLabel?.widthAnchor
            .constraint(greaterThanOrEqualToConstant: constants.actionListAccessoryDetailMinimumWidth),
           let accessoryImageWidth = accessoryImageView?.widthAnchor
            .constraint(equalToConstant: imageSize.width) {
            NSLayoutConstraint.activate([detailWidthMininum, accessoryImageWidth])
        }
        
        accessoryView = accessoryStackView
    }
    
    private func styleAccessoryViews(theme: Theme) {
        accessoryStatusView?.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        accessoryStatusView?.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        accessoryDetailLabel?.numberOfLines = 0
        accessoryDetailLabel?.textAlignment = .right
        accessoryDetailLabel?.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        accessoryDetailLabel?.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        accessoryImageView?.contentMode = .scaleAspectFit
        accessoryImageView?.image = theme.images.caretRight
        accessoryImageView?.tintColor = theme.colors.tintActionListIcon
        accessoryImageView?.setContentHuggingPriority(UILayoutPriority(900), for: .horizontal)
        
        accessoryStackView?.distribution = .fill
        accessoryStackView?.spacing = theme.constants.actionListAccessoryViewSpacing
    }
}
