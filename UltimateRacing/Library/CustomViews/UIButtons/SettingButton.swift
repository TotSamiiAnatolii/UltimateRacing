//
//  SettingButton.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

final class SettingButton: UIButton {
    
    override var isHighlighted: Bool {
        
        didSet {
            
            if isHighlighted {
                touchDown()
            } else {
                touchUp()
            }
        }
    }
    
    private func touchDown() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 0.5
            self.transform = CGAffineTransform(rotationAngle: .pi / 4)
        }, completion: nil)
        
    }
    
    private func touchUp() {
        
        imageView?.image = Images.buttonSetting
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(rotationAngle: -.pi / 4)
        }, completion: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(image: UIImage) {
        super.init(frame: .zero)
        setImage(image, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

