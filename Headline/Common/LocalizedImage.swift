//
//  LocalizedImage.swift
//  Headline
//
//  Created by Hugo Pivaral on 6/07/22.
//

import UIKit

enum LocalizedImage: String {
    
    case actionsArrowDown = "actions-arrow-down"
    case actionsArrowRight = "actions-arrow-right"
    case emptyStateImage = "empty-state-image"
    case iconsClock = "icons-clock"
}

extension UIImage {
    
    convenience init(image: LocalizedImage) {
        self.init(named: image.rawValue)!
    }
}
