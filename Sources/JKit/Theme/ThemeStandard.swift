import UIKit

// MARK: - ThemeStandard: Theme, Bundlable

public struct ThemeStandard: Theme, Bundlable {
    
    // MARK: Properties

    public let colors: Colors = ColorsStandard()
    public let constants: Constants = ConstantsStandard()
    public let images: Images = ImagesStandard()

    // MARK: Initializer

    public init() {
        // load fonts
        InterFont.loadFonts()
                
        let navBarTitleAttributes = [NSAttributedString.Key.font: FontStyle.h3.font as Any]
        let barButtonTitleAttributes = [NSAttributedString.Key.font: FontStyle.h4.font as Any]
        
        // set appearances
        UINavigationBar.appearance().titleTextAttributes = navBarTitleAttributes
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonTitleAttributes, for: .normal)
    }
}
