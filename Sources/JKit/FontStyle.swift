import UIKit

// MARK: - FontStyle

public enum FontStyle {
    case h1
    case h2
    case h3
    case h4
    case label
    case body
    case caption

    // MARK: Properties
    
    public var font: UIFont {
        let customFont: UIFont?
        switch self {
        case .h1, .h2: customFont = UIFont(name: InterFont.semiBold.name, size: size)
        case .h3, .h4, .label: customFont = UIFont(name: InterFont.medium.name, size: size)
        case .body, .caption: customFont = UIFont(name: InterFont.regular.name, size: size)        
        }
        
        return customFont ?? UIFont.systemFont(ofSize: size, weight: weight)
    }

    var letterSpacing: CGFloat {
        return 0
    }

    var lineBreakMode: NSLineBreakMode {
        return .byWordWrapping
    }

    var lineSpacing: CGFloat { return lineHeight / size }

    private var weight: UIFont.Weight {
        switch self {
        case .h1, .h2: return .semibold
        case .h3, .h4, .label: return .medium
        case .body, .caption: return .regular
        }
    }

    public var size: CGFloat {
        switch self {
        case .h1: return 30
        case .h2: return 24
        case .h3: return 18
        case .h4: return 16
        case .label, .body: return 14
        case .caption: return 12
        }
    }
    
    public var lineHeight: CGFloat {
        switch self {
        case .h1: return 40
        case .h2: return 26
        case .h3: return 24
        case .h4: return 22
        case .label, .body: return 20
        case .caption: return 14
        }
    }

    // MARK: Helpers

    public func attributesWith(
        textColor: UIColor,
        alignment: NSTextAlignment = .left,
        indentation: CGFloat = 0,
        lineBreakMode customLineBreakMode: NSLineBreakMode? = nil,
        additionalAttributes: [NSAttributedString.Key: Any] = [:]) -> [NSAttributedString.Key: Any] {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = customLineBreakMode ?? lineBreakMode
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        paragraphStyle.firstLineHeadIndent = indentation
        paragraphStyle.headIndent = indentation

        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        attributes[NSAttributedString.Key.kern] = letterSpacing
        attributes[NSAttributedString.Key.font] = font

        for attribute in additionalAttributes {
            attributes[attribute.key] = attribute.value
        }

        return attributes
    }

    /// Returns a set of attributes which will underline attributed text.
    /// - Returns: Set of attributes for underlining attributed text.
    public static func attributesUnderline() -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
    }
}

// MARK: InterFont

public enum InterFont {
    case black
    case bold
    case extraBold
    case extraLight
    case light
    case medium
    case regular
    case semiBold
    case thin
    
    public static let fileExtension = "ttf"
    public static let family = "Inter"
    
    public var fileName: String {
        switch self {
        case .black: return "Inter-Black-slnt=0"
        case .bold: return "Inter-Bold-slnt=0"
        case .extraBold: return "Inter-ExtraBold-slnt=0"
        case .extraLight: return "Inter-ExtraLight-slnt=0"
        case .light: return "Inter-Light-slnt=0"
        case .medium: return "Inter-Medium-slnt=0"
        case .regular: return "Inter-Regular-slnt=0"
        case .semiBold: return "Inter-SemiBold-slnt=0"
        case .thin: return "Inter-Thin-slnt=0"
        }
    }
    
    public var name: String {
        switch self {
        case .black: return "Inter-Black"
        case .bold: return "Inter-Bold"
        case .extraBold: return "Inter-ExtraBold"
        case .extraLight: return "Inter-ExtraLight"
        case .light: return "Inter-Light"
        case .medium: return "Inter-Medium"
        case .regular: return "Inter-Regular"
        case .semiBold: return "Inter-SemiBold"
        case .thin: return "Inter-Thin"
        }
    }
    
    public static func loadFonts() {
        guard let bundle = ThemeStandard.bundle else { return }
        
        let fonts: [InterFont] = [
            .black,
            .bold,
            .extraBold,
            .extraLight,
            .light,
            .medium,
            .regular,
            .semiBold,
            .thin
        ]
        
        for font in fonts {
            _ = UIFont.registerFont(bundle: bundle,
                                    fontName: font.fileName,
                                    fontExtension: InterFont.fileExtension)
        }
    }
}
