//
//  String+Extensions.swift
//  Headline
//
//  Created by Hugo Pivaral on 28/07/22.
//

import UIKit

extension String {
    
    public func attributed(with font: UIFont, color: UIColor, lineSpacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributes: [NSAttributedString.Key : Any] = [ .font: font,
                                                           .foregroundColor : color,
                                                           .paragraphStyle : paragraphStyle ]
        
        return NSAttributedString(string: self, attributes: attributes)
    }
}
