//
//  BookDetailPopTransition.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/06.
//

import UIKit

class BookDetailPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    fileprivate let toDelegate: BookDetailTransitionAnimatorDelegate
    fileprivate let bookDetailVC: BookDetailViewController
    
    fileprivate let transitionImageView = TransitionImageView()
    
    init?(
        toDelegate: Any,
        fromBookDetailVC bookDetailVC: BookDetailViewController
    ) {
        guard let toDelegate = toDelegate as? BookDetailTransitionAnimatorDelegate else {
            return nil
        }
        
        self.toDelegate = toDelegate
        self.bookDetailVC = bookDetailVC
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.38
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        let containerView = transitionContext.containerView
        let fromReferenceFrame = bookDetailVC.imageFrame() ?? .zero
        
        let transitionImage = bookDetailVC.referenceImage()
        transitionImageView.image = transitionImage
        transitionImageView.frame = bookDetailVC.imageFrame() ?? .zero
        
        [toView, fromView]
            .compactMap { $0 }
            .forEach { containerView.addSubview($0) }
        containerView.addSubview(transitionImageView)
        
        self.bookDetailVC.transitionWillStart()
        self.toDelegate.transitionWillStart()
        
        let duration = self.transitionDuration(using: transitionContext)
        let spring: CGFloat = 0.9
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: spring) {
            fromView?.alpha = 0
        }
        
        animator.addCompletion { [weak self] position in
            guard let self = self else { return }
            self.transitionImageView.removeFromSuperview()
            self.transitionImageView.image = nil
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            self.toDelegate.transitionDidEnd()
            self.bookDetailVC.transitionDidEnd()
        }
        animator.startAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
            animator.addAnimations { [weak self] in
                guard let self = self else { return }
                let toReferenceFrame = self.toDelegate.imageFrame() ??
                BookDetailPopTransition.defaultOffscreenFrameForDismissal(
                    transitionImageSize: fromReferenceFrame.size,
                    screenHeight: containerView.bounds.height
                )
                self.transitionImageView.frame = toReferenceFrame
            }
        }
    }
    
    static func defaultOffscreenFrameForDismissal(transitionImageSize: CGSize,
                                                         screenHeight: CGFloat) -> CGRect {
        return CGRect(
            x: 0,
            y: screenHeight,
            width: transitionImageSize.width,
            height: transitionImageSize.height
        )
    }
}
