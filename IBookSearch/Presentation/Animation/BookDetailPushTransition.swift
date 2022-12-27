//
//  BookDetailPushTransition.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/06.
//

import UIKit

final public class BookDetailPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    fileprivate let fromDelegate: BookDetailTransitionAnimatorDelegate
    fileprivate let bookDetailVC: BookDetailViewController
    fileprivate let transitionImageView = TransitionImageView()
    
    init?(fromDelegate: Any,
          toBookDetailVC bookDetailVC: BookDetailViewController) {
        guard let fromDelegate = fromDelegate as? BookDetailTransitionAnimatorDelegate else {
            return nil
        }
        self.fromDelegate = fromDelegate
        self.bookDetailVC = bookDetailVC
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.38
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        
        let containerView = transitionContext.containerView
        toView?.alpha = 0
        
        [fromView, toView]
            .compactMap { $0 }
            .forEach { containerView.addSubview($0) }
        
        let transitionImage = fromDelegate.referenceImage() ?? UIImage()
        transitionImageView.image = transitionImage
        containerView.addSubview(transitionImageView)
        
        transitionImageView.frame = fromDelegate.imageFrame() ?? BookDetailPushTransition.defaultOffscreenFrameForPresentation(image: transitionImage, forView: toView)
        let toReferenceFrame = BookDetailPushTransition.calculateZoomInImageFrame(image: transitionImage, forView: toView)
        
        fromDelegate.transitionWillStart()
        bookDetailVC.transitionWillStart()
        
        let duration = transitionDuration(using: transitionContext)
        let spring: CGFloat = 0.95
        
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: spring) { [weak self] in
            self?.transitionImageView.frame = toReferenceFrame
            toView?.alpha = 1
        }
        
        animator.addCompletion { [weak self] (position) in
            guard let self = self else { return }
            self.transitionImageView.removeFromSuperview()
            self.transitionImageView.image = nil
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            self.bookDetailVC.transitionDidEnd()
            self.fromDelegate.transitionDidEnd()
        }
        
        animator.startAnimation()
    }
    
    private static func defaultOffscreenFrameForPresentation(image: UIImage,
                                                             forView view: UIView?) -> CGRect {
        var result = BookDetailPushTransition.calculateZoomInImageFrame(image: image, forView: view)
        result.origin.y = view?.bounds.height ?? 0
        return result
    }
    
    private static func calculateZoomInImageFrame(image: UIImage,
                                                  forView view: UIView?) -> CGRect {
        let width = UIScreen.main.bounds.width
        let size = CGSize(width: width, height: width)
        var rect = CGRect.makeRect(aspectRatio: size, insideRect: view?.bounds ?? .zero)
        rect.origin.y = view?.safeAreaInsets.top ?? 0
        return rect
    }
}
