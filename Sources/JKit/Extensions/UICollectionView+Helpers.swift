import UIKit

// MARK: - UICollectionView (Helpers)

extension UICollectionView {
    /// Registers a `BaseCollectionViewCell` for reuse.
    /// - Parameter _: The type of `BaseCollectionViewCell` to register.
    public func registerCellWithType<T: BaseCollectionViewCell>(_: T.Type) {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        register(T.self, forCellWithReuseIdentifier: className)
    }
    
    /// Dequeues a reusable `BaseCollectionViewCell`.
    /// - Parameters:
    ///   - indexPath: The index path specifying the location of the cell.
    ///   - theme: The theme used for styling of the cell.
    /// - Returns: A reusable `BaseCollectionViewCell`.
    public func dequeueReusableCellWithExplicitType<T: BaseCollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("could not dequeue cell with identifier: \(className)")
        }
        
        return cell
    }
    
    /// Registers a `BaseCollectionReusableView` for reuse.
    public func registerSupplementaryViewWithType<T: BaseCollectionReusableView>(_: T.Type) {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        register(T.self, forSupplementaryViewOfKind: className, withReuseIdentifier: className)
    }
    
    /// Dequeues a reusable `BaseCollectionReusableView`.
    /// - Returns: A reusable `BaseCollectionReusableView`.
    public func dequeueSupplementaryViewWithExplicitType<T: BaseCollectionReusableView>(indexPath: IndexPath) -> T {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        guard let view = dequeueReusableSupplementaryView(ofKind: className,
                                                          withReuseIdentifier: className,
                                                          for: indexPath) as? T else {
            fatalError("could not dequeue supplementary view identifier: \(className)")
        }
        return view
    }
}
