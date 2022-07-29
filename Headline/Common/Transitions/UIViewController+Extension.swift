//
//  UIViewController+Extension.swift
//  Headline
//
//  Created by Hugo Pivaral on 24/07/22.
//

import UIKit

typealias UIViewControllerCustomPresentable = UIViewController & CustomPresentable

extension UIViewController {
    
    func present(viewController: UIViewControllerCustomPresentable,
                 interactiveDismissalType: InteractiveDismissalType,
                 presentationPosition: CustomPresentationPosition = .bottom,
                 presentationStyle: CustomPresentationStyle = .card,
                 completion: (() -> Void)? = nil) {
        
        let interactionController: InteractionControlling?
        interactionController = StandardInteractionController(viewController: viewController)
        
        let transitionManager = ModalTransitionManager(interactionController: interactionController)
        
        viewController.transitionManager = transitionManager
        viewController.transitioningDelegate = transitionManager
        viewController.modalPresentationStyle = .custom
        
        present(viewController, animated: true, completion: completion)
    }
}

enum CustomPresentationPosition {
    case top
    case center
    case bottom
}

enum CustomPresentationStyle {
    case sheet
    case card
}
