//
//  BookListViewController.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/05.
//

import UIKit

extension BookListViewController: BookDetailTransitionAnimatorDelegate {    
    func transitionWillStart() {
        guard let lastSelected = lastSelectedIndexPath else { return }
        collectionView.cellForItem(at: lastSelected)?.isHidden = true
    }

    func transitionDidEnd() {
        guard let lastSelected = lastSelectedIndexPath else { return }
        collectionView.cellForItem(at: lastSelected)?.isHidden = false
    }

    func referenceImage() -> UIImage? {
        guard
            let lastSelected = lastSelectedIndexPath,
            let cell = collectionView.cellForItem(at: lastSelected) as? BaseCollectionViewCell
        else {
            return nil
        }
        return cell.bookImageView.image
    }
    
    func imageFrame() -> CGRect? {
        guard let lastSelected = lastSelectedIndexPath,
              let cell = collectionView.cellForItem(at: lastSelected) as? BaseCollectionViewCell
        else {
            return nil
        }
        let size = cell.bookImageView.frame.size
        var origin = cell.frame.origin
        origin.x += 6
        let rect = CGRect(origin: origin, size: size)
        return collectionView.convert(rect, to: view)
    }
}
