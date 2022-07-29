//
//  CustomPresentable.swift
//  Headline
//
//  Created by Hugo Pivaral on 23/07/22.
//

import UIKit

protocol CustomPresentable: UIViewController {
    
    var transitionManager: ModalTransitionManagerProvider? { get set }
    var dismissalHandlingScrollView: UIScrollView? { get }
    
    func updatePresentationLayout(animated: Bool)
}

extension CustomPresentable {
    
    var dismissalHandlingScrollView: UIScrollView? { nil }
    
    func updatePresentationLayout(animated: Bool) {
        guard let presentationController = presentationController,
              let containerView = presentationController.containerView else { return }
        
        containerView.setNeedsLayout()
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction) { containerView.layoutIfNeeded() }
        } else {
            containerView.layoutIfNeeded()
        }
    }
}
