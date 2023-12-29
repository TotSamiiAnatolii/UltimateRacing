//
//  UIButton+MyStyle.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

extension UIButton {
    
    public typealias Func = () -> ()
    
    public func setMyStyle(backgroundColor: UIColor) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = AppDesign.mainCornerRadius
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = false
        return self
    }
    
    public func setTarget( method methodDown: Selector, target: Any, event: UIControl.Event ) -> Self {

        self.addTarget(target, action: methodDown.self, for: event)
        
        return self
    }
    
    public func addImage(image: UIImage?) -> Self {
        guard let image = image else {return self}
        let highlighted = image.withAlpha(0.5)
        self.setImage(image, for: .normal)
        self.setImage(highlighted, for: .highlighted)
        return self
    }
}

extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}
