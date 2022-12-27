//
//  BookDetailViewController+Extension.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/05.
//

import UIKit

extension BookDetailViewController: BookDetailTransitionAnimatorDelegate {
    
    func transitionWillStart() {
        collectionView.isHidden = true
    }

    func transitionDidEnd() {
        collectionView.isHidden = false
    }

    func referenceImage() -> UIImage? {
        return displayCell?.imageView.image
    }
    
    func imageFrame() -> CGRect? {
        let width = view.frame.width
        let size = CGSize(width: width, height: 80)
        let rect = CGRect.makeRect(aspectRatio: size, insideRect: displayCell?.frame ?? .zero)
        return rect
    }
}
