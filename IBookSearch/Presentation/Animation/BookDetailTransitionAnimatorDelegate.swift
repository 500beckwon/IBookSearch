//
//  BookDetailTransitionAnimatorDelegate.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/06.
//

import UIKit

protocol BookDetailTransitionAnimatorDelegate: AnyObject {
    func transitionWillStart()
    func transitionDidEnd()
    func referenceImage() -> UIImage?
    func imageFrame() -> CGRect?
}
