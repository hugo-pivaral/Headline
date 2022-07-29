//
//  InteractionControlling.swift
//  Headline
//
//  Created by Hugo Pivaral on 23/07/22.
//

import UIKit

protocol InteractionControlling: UIViewControllerInteractiveTransitioning {
    
    var interactionInProgress: Bool { get }
}
