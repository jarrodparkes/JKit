import UIKit

// MARK: - ThemeStandard: Theme, Bundlable

public struct ThemeStandard: Theme, Bundlable {
    
    // MARK: Properties

    public let colors: Colors = ColorsStandard()
    public let constants: Constants = ConstantsStandard()
    public let images: Images = ImagesStandard()

    // MARK: Initializer

    public init () {}

    // MARK: Helpers

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
