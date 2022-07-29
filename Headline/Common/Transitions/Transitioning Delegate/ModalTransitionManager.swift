//
//  ModalTransitionManager.swift
//  Headline
//
//  Created by Hugo Pivaral on 23/07/22.
//

import UIKit


// MARK: Provider

protocol ModalTransitionManagerProvider: UIViewControllerTransitioningDelegate {
    
    var interactionController: InteractionControlling? { get }
}


// MARK: Modal transition manager
 
class ModalTransitionManager: NSObject, ModalTransitionManagerProvider {
    
    var interactionController: InteractionControlling?
    
    init(interactionController: InteractionControlling?) {
        self.interactionController = interactionController
    }
}


// MARK: UIViewControllerTransitioning delegate conformance

extension ModalTransitionManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ModalTransitionAnimator(presenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ModalTransitionAnimator(presenting: false)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactionController = interactionController, interactionController.interactionInProgress else { return nil }
        
        return interactionController
    }
    
}
