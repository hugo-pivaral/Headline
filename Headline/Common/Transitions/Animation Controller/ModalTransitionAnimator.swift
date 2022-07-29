//
//  ModalTransitionAnimator.swift
//  Headline
//
//  Created by Hugo Pivaral on 25/07/22.
//

import UIKit

class ModalTransitionAnimator: NSObject {
    
    private let presenting: Bool
    
    private let dismissedFrame: (UIViewControllerContextTransitioning, CGRect) -> CGRect  = { context, presentedFrame in
        CGRect(x: presentedFrame.minX, y: context.containerView.bounds.height, width: presentedFrame.width, height: presentedFrame.height)
    }
    
    init(presenting: Bool) {
        self.presenting = presenting
    }
}


extension ModalTransitionAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if presenting {
            presentAnimated(using: transitionContext)
        } else {
            dismissAnimated(using: transitionContext)
        }
    }
    
    private func presentAnimated(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedViewController = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(presentedViewController.view)
        
        let presentedFrame = transitionContext.finalFrame(for: presentedViewController)
        
        presentedViewController.view.frame = dismissedFrame(transitionContext, presentedFrame)
        presentedViewController.view.layer.cornerRadius = 30
        presentedViewController.view.layer.masksToBounds = true
        
        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 1.0) {
            presentedViewController.view.frame = presentedFrame
        }
        
        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        animator.startAnimation()
        
    }
    
    private func dismissAnimated(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedViewController = transitionContext.viewController(forKey: .from) else { return }
        
        let presentedFrame = transitionContext.finalFrame(for: presentedViewController)
        
        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 1.0) { [weak self] in
            guard let self = self else { return }
            presentedViewController.view.frame = self.dismissedFrame(transitionContext, presentedFrame)
        }
        
        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        animator.startAnimation()
    }
}
