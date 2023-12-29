//
//  UILabel+MyStyle.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

extension UILabel {
    
    public func setMyStyle(numberOfLines: Int, textAlignment: NSTextAlignment, font: UIFont) -> Self {
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        self.font = font
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    public func setTextColor(color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    public func setLineBreakMode(lineBreak: NSLineBreakMode ) -> Self {
        self.lineBreakMode = lineBreak
        return self
    }
}

