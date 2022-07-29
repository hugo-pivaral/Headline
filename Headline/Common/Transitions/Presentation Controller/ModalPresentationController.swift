//
//  ModalPresentationController.swift
//  Headline
//
//  Created by Hugo Pivaral on 24/07/22.
//

import UIKit

class ModalPresentationController: UIPresentationController {
    
    
    // MARK: Properties
    
    lazy var dimmingView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .black.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        
        return view
    }()
    
    lazy var draggerView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 2.5
        view.layer.masksToBounds = true
        view.backgroundColor = .systemFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    // MARK: Overrides
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        containerView.insertSubview(dimmingView, at: 0)
        
        dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            
            return
        }
        
        coordinator.animate { [weak self] _ in
            self?.dimmingView.alpha = 1.0
        }
        
        guard let presentedView = presentedView else { return }
        
        presentedView.insertSubview(draggerView, at: 100)
        
        draggerView.topAnchor.constraint(equalTo: presentedView.topAnchor, constant: 10).isActive = true
        draggerView.centerXAnchor.constraint(equalTo: presentedView.centerXAnchor).isActive = true
        draggerView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        draggerView.widthAnchor.constraint(equalToConstant: 36.0).isActive = true
        
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            
            return
        }
        
        guard !coordinator.isInteractive else { return }
        
        coordinator.animate { [weak self] _ in
            self?.dimmingView.alpha = 0.0
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView, let presentedView = presentedView else { return .zero }
        
        let inset: CGFloat = 10.0
        let safeAreaFrame = containerView.bounds.inset(by: containerView.safeAreaInsets)
        
        let fittingSize = CGSize(width: safeAreaFrame.width - (inset * 2),
                                 height: UIView.layoutFittingCompressedSize.height)
        
        let targetSize = presentedView.systemLayoutSizeFitting(fittingSize,
                                                               withHorizontalFittingPriority: .required,
                                                               verticalFittingPriority: .defaultLow)
        
        var frame = safeAreaFrame
        frame.size = targetSize
        frame.origin.x += inset
        frame.origin.y += (safeAreaFrame.height - targetSize.height)
        
        return frame
    }
}
