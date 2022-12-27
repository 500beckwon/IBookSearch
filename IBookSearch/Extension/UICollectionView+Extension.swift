//
//  UICollectionView+Extension.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/04.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cell: T.Type) {
        register(cell.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                                           for: indexPath) as? T else {
            fatalError("Unable to dequeue Reusable UICollectionViewCell")
        }
        return cell
    }
    
    func cellForItem<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        return  cellForItem(at: indexPath) as? T
    }
}
