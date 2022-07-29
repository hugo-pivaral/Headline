//
//  LocalizedFont.swift
//  Headline
//
//  Created by Hugo Pivaral on 9/07/22.
//

import UIKit

enum HeadlineFont: String {
    
    case georgia = "Georgia"
    
    enum Weight: String {
        case bold
        case italic
        case regular
    }
}

extension UIFont {
    
    convenience init(font: HeadlineFont, weight: HeadlineFont.Weight, size: CGFloat) {
        self.init(name: "\(font.rawValue)-\(weight.rawValue)", size: size)!
    }
}
