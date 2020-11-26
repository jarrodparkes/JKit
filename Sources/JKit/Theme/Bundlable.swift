import Foundation

// MARK: - Bundlable

/// An object which provides access to JKit bundle.
public protocol Bundlable {}

// MARK: - Bundlable (Defaults)

extension Bundlable {
    static var bundle: Bundle? {
        return Bundle.module
    }
}
