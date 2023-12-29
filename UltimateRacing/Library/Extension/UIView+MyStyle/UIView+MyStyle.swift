//
//  UIView+MyStyle.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

extension UIView {
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
    
    public func setStyle() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        return self
    }
    
    public func setColor(color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    public func setRoundCorners(radius: CGFloat) -> Self {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        return self
    }
    
    public func setShadow() -> Self {
        self.layer.shadowColor = Colors.shadowColor
        self.layer.shadowOffset = CGSize(width: 0.1, height: 3.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        return self
    }
}

extension CALayer {
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        cornerRadius = radius
        maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}
