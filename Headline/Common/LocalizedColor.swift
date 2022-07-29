//
//  UIColor+Extensions.swift
//  Headline
//
//  Created by Hugo Pivaral on 6/07/22.
//

import UIKit

enum LocalizedColor: String {
    
    case backgroundPrimary = "background-primary"
    case backgroundSecondary = "background-secondary"
    case backgroundTertiary = "background-tertiary"
    case contentPrimary = "content-primary"
    case contentSecondary = "content-secondary"
    case primaryTint = "primary-tint"
}

extension UIColor {
    
    convenience init(color: LocalizedColor) {
        self.init(named: color.rawValue)!
    }
}
