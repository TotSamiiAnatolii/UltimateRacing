//
//  UIImageView+MyStyle.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

extension UIImageView {
    
    public func setMyStyle(corner: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.cornerRadius = corner
        clipsToBounds = true
        return self
    }
    
    public func setImage(image: UIImage?) -> Self {
        self.image = image
        return self
    }
    
    public func setTintColor(color: UIColor) -> Self {
        tintColor = color
        return self
    }
}
