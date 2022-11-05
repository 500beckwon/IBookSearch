//
//  SelectAnimationNavigationViewController.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/05.
//

import UIKit

class SelectAnimationNavigationViewController: UINavigationController {
    
    fileprivate var currentAnimationTransition: UIViewControllerAnimatedTransitioning? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension SelectAnimationNavigationViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        let result: UIViewControllerAnimatedTransitioning?
        if let bookDetailVC = toVC as? BookDetailViewController,
           operation == .push {
            result = BookDetailPushTransition(fromDelegate: fromVC, toBookDetailVC: bookDetailVC)
        } else if let bookDetailVC = fromVC as? BookDetailViewController, operation == .pop {
            if bookDetailVC.isInteractivelyDismissing {
                result = BookDetailInteractiveDismissTransition(fromDelegate: bookDetailVC, toDelegate: toVC)
            } else {
                result = BookDetailPopTransition(toDelegate: toVC, fromBookDetailVC: bookDetailVC)
            }
        } else {
            result = nil
        }
        
        return result
    }
    
    public func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        return self.currentAnimationTransition as? UIViewControllerInteractiveTransitioning
    }
    
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        self.currentAnimationTransition = nil
    }
}
