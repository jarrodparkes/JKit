// MARK: - Theme

/// An object that defines all the individual components contained within JKit.
public protocol Theme {
    /// An object that defines all the colors for JKit.
    var colors: Colors { get }

    /// An object that defines all the constants for JKit.
    var constants: Constants { get }

    /// An object that defines all the images for JKit.
    var images: Images { get }
}
