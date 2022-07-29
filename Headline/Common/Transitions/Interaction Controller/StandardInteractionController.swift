//
//  StandardInteractionController.swift
//  Headline
//
//  Created by Hugo Pivaral on 23/07/22.
//

import UIKit

class StandardInteractionController: NSObject, InteractionControlling {
    
    
    // MARK: Properties
    
    var interactionInProgress: Bool = false
    
    private var springVelocity: (CGFloat, CGFloat) -> CGFloat = { distanceToTravel, gestureVelocity in distanceToTravel == 0 ? 0 : gestureVelocity / distanceToTravel }
    
    private var viewController: UIViewControllerCustomPresentable!
    
    private weak var transitionContext: UIViewControllerContextTransitioning!
    private var cancellationAnimator: UIViewPropertyAnimator?
    private var finishAnimator: UIViewPropertyAnimator?
    private var interactionDistance: CGFloat = 0
    private var presentedFrame: CGRect!
    private var interruptedTranslation: CGFloat = 0
    private var interruptedDistance: CGFloat = 0
    
    
    // MARK: Initializer
    
    init(viewController: UIViewControllerCustomPresentable) {
        self.viewController = viewController
        super.init()
        addGestureRecognizer()
        resolveScrollViewGestures()
    }
    
    
    // MARK: - Actions
    
    @objc private func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let superview = gestureRecognizer.view?.superview else { return }
        
        let yTranslation = gestureRecognizer.translation(in: superview).y
        let yVelocity = gestureRecognizer.velocity(in: superview).y
        
        switch gestureRecognizer.state {
        case .began:
            gestureBegan()
        case .changed:
            gestureChanged(translation: yTranslation, velocity: yVelocity)
        case .ended:
            gestureEnded(translation: yTranslation, velocity: yVelocity)
        case .cancelled:
            gestureCancelled(translation: yTranslation, velocity: yVelocity)
        default:
            break
        }
    }
    
    
    // MARK: Gesture state methods
    
    private func gestureBegan() {
        disableUserInteraction()
        cancellationAnimator?.stopAnimation(true)
        
        if let presentedFrame = presentedFrame {
            interruptedTranslation = viewController.view.frame.minY - presentedFrame.minY
        }
        
        if !interactionInProgress {
            interactionInProgress = true
            viewController.dismiss(animated: true)
        }
    }
    
    private func gestureChanged(translation: CGFloat, velocity: CGFloat) {
        var progress = interactionDistance == 0 ? 0 : (translation / interactionDistance)
        if progress < 0 {
            progress /= 1.0 + abs(progress * 20)
        }
        
        update(progress: progress)
    }
    
    private func gestureEnded(translation: CGFloat, velocity: CGFloat) {
        let shouldFinishDismiss = velocity > 300 || (translation > interactionDistance / 2.0 && velocity > -300)
        
        if shouldFinishDismiss {
            finish(initialSpringVelocity: springVelocity(interactionDistance - translation, velocity))
        } else {
            cancel(initialSpringVelocity: springVelocity(-translation, velocity))
        }
        
    }
    
    private func gestureCancelled(translation: CGFloat, velocity: CGFloat) {
        cancel(initialSpringVelocity: springVelocity(-translation, velocity))
    }
    
    
    
    // MARK: Animation handlers
    
    func update(progress: CGFloat) {
        guard let transitionContext = transitionContext,
              let presentedViewController = transitionContext.viewController(forKey: .from),
              let presentedFrame = presentedFrame else { return }
        
        transitionContext.updateInteractiveTransition(progress)
        presentedViewController.view.frame = CGRect(x: presentedFrame.minX,
                                                    y: presentedFrame.minY + interactionDistance * progress,
                                                    width: presentedFrame.width,
                                                    height: presentedFrame.height)
        
        if let modalPresentationController = presentedViewController.presentationController as? ModalPresentationController {
            modalPresentationController.dimmingView.alpha = 1.0 - progress
        }
    }
    
    func cancel(initialSpringVelocity: CGFloat) {
        guard let transitionContext = transitionContext,
              let presentedViewController = transitionContext.viewController(forKey: .from),
              let presentedFrame = presentedFrame else { return }
        
        let timingParameters = UISpringTimingParameters(dampingRatio: 0.8, initialVelocity: CGVector(dx: 0, dy: initialSpringVelocity))
        cancellationAnimator = UIViewPropertyAnimator(duration: 0.5, timingParameters: timingParameters)
        
        cancellationAnimator?.addAnimations {
            presentedViewController.view.frame = presentedFrame
            if let modalPresentationController = presentedViewController.presentationController as? ModalPresentationController {
                modalPresentationController.dimmingView.alpha = 1.0
            }
        }
        
        cancellationAnimator?.addCompletion({ [weak self] _ in
            transitionContext.cancelInteractiveTransition()
            transitionContext.completeTransition(false)
            self?.interactionInProgress = false
            self?.enableUserInteraction()
        })
        
        cancellationAnimator?.startAnimation()
    }
    
    func finish(initialSpringVelocity: CGFloat) {
        guard let transitionContext = transitionContext,
              let presentedViewController = transitionContext.viewController(forKey: .from) as? CustomPresentable,
              let presentedFrame = presentedFrame else { return }
        
        let dismissedFrame = CGRect(x: presentedFrame.minX,
                                    y: transitionContext.containerView.bounds.height,
                                    width: presentedFrame.width,
                                    height: presentedFrame.height)
        
        let timingParameters = UISpringTimingParameters(dampingRatio: 0.8, initialVelocity: CGVector(dx: 0, dy: initialSpringVelocity))
        finishAnimator = UIViewPropertyAnimator(duration: 0.5, timingParameters: timingParameters)
        
        finishAnimator?.addAnimations {
            presentedViewController.view.frame = dismissedFrame
            if let modalPresentationController = presentedViewController.presentationController as? ModalPresentationController {
                modalPresentationController.dimmingView.alpha = 0.0
            }
        }
        
        finishAnimator?.addCompletion({ _ in
            transitionContext.finishInteractiveTransition()
            transitionContext.completeTransition(true)
            self.interactionInProgress = false
        })
        
        finishAnimator?.startAnimation()
    }
    
    
    // MARK: Helper methods
    
    private func addGestureRecognizer() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        viewController.view.addGestureRecognizer(gesture)
    }
    
    private func resolveScrollViewGestures() {
        guard let scrollView = viewController.dismissalHandlingScrollView else { return }
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        gesture.delegate = self
        
        scrollView.addGestureRecognizer(gesture)
        scrollView.panGestureRecognizer.require(toFail: gesture)
    }
    
    private func disableUserInteraction() {
        viewController.view.subviews.forEach { view in
            view.isUserInteractionEnabled = false
        }
    }
    
    private func enableUserInteraction() {
        viewController.view.subviews.forEach { view in
            view.isUserInteractionEnabled = true
        }
    }
    
    
    // MARK: Interactive transitioning conformance
    
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedViewController = transitionContext.viewController(forKey: .from) else { return }
        
        self.transitionContext = transitionContext
        self.presentedFrame = transitionContext.finalFrame(for: presentedViewController)
        self.interactionDistance = transitionContext.containerView.bounds.height - presentedFrame.minY
    }
}


// MARK: - Gesture recognizer delegate

extension StandardInteractionController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let scrollView = viewController.dismissalHandlingScrollView {
            return scrollView.contentOffset.y <= 0
        }
        
        return true
    }
}
