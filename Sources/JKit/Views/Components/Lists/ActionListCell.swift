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

// MARK: - ActionListCell: BaseCollectionViewCell

public class ActionListCell: BaseCollectionViewCell {

    // MARK: Properties
    
    private let stackView = UIStackView(frame: .zero)
    private let imageView = UIImageView(frame: .zero)
    private let titleStackView = UIStackView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
        
    var accessoryDetailLabel: UILabel?
    var accessoryImageView: UIImageView?
    var accessoryStackView: UIStackView?
    
    // MARK: BaseCollectionViewCell
    
    public override func addSubviews() {
        stackView.addArrangedSubview(imageView)
        
        titleStackView.axis = .vertical
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(titleStackView)
      
        contentView.addSubview(stackView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            imageView.heightAnchor.constraint(equalToConstant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }
            
    // MARK: Style

    public func styleWith(theme: Theme, displayable: ActionListCellDisplayable) {
        super.styleWith(theme: theme)
        
        let colors = theme.colors
        let constants = theme.constants
                
        stackView.spacing = constants.actionListContentSpacing
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = constants.actionListContentInsets
                
        titleStackView.spacing = constants.actionListTitleSpacing
        
        if case .none = displayable.accessoryStyle {} else if accessoryStackView == nil {
            addAccessoryViews(theme: theme)
        }
                
        let textColor = colors.textHighEmphasis

        // background
        backgroundColor = displayable.customBackgroundColor(colors: colors) ?? colors.backgroundCell

        // icon
        imageView.contentMode = .scaleAspectFit
        imageView.image = displayable.icon
        imageView.isHidden = displayable.icon == nil
        imageView.tintColor = displayable.customIconTintColor(colors: colors) ?? colors.tintActionListIcon

        // title
        let titleTextColor = displayable.customTitleTextColor(colors: colors) ?? textColor
        titleLabel.numberOfLines = 0
        titleLabel.attributedText = displayable.title.attributed(fontStyle: .label, color: titleTextColor)

        // subtitle
        let subtitle = displayable.subtitle ?? ""        
        subtitleLabel.numberOfLines = 0
        subtitleLabel.attributedText = subtitle.attributed(fontStyle: .body, color: textColor)
        subtitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        subtitleLabel.isHidden = displayable.subtitle.isEmptyOrNil

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
            accessoryImageView?.isHidden = true
            accessoryStackView?.isHidden = detailString.isEmpty
        case .detailAndNavigation(_, let navigationStyle):
            accessoryImageView?.isHidden = false
            accessoryImageView?.image = navigationStyle.icon(images: theme.images)
            accessoryStackView?.isHidden = (detailString.isEmpty && navigationStyle == .none)
        case .none:
            accessoryStackView?.isHidden = true
        }
    }
    
    private func addAccessoryViews(theme: Theme) {
        let constants = theme.constants
        let imageSize = constants.actionListAccessoryImageSize
                
        accessoryDetailLabel = UILabel(frame: .zero)
        accessoryImageView = UIImageView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: imageSize.width,
                                                       height: imageSize.height))
        
        accessoryStackView = UIStackView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: constants.actionListAccessoryDetailAndImageWidth,
                                                       height: frame.height))
        accessoryStackView?.alignment = .center
                
        accessoryStackView?.addArrangedSubview(accessoryDetailLabel ?? UILabel())
        accessoryStackView?.addArrangedSubview(accessoryImageView ?? UIImageView())
        
        if let detailWidthMininum = accessoryDetailLabel?.widthAnchor
            .constraint(greaterThanOrEqualToConstant: constants.actionListAccessoryDetailMinimumWidth),
           let accessoryImageWidth = accessoryImageView?.widthAnchor
            .constraint(equalToConstant: imageSize.width) {
            NSLayoutConstraint.activate([detailWidthMininum, accessoryImageWidth])
        }
        
        if let accessoryStackView = accessoryStackView {
            stackView.addArrangedSubview(accessoryStackView)
        }
    }
    
    private func styleAccessoryViews(theme: Theme) {
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
