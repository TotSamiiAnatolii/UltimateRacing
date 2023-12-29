//
//  UITextField+BorderStyle.swift
//  UltimateRacing
//
//  Created by APPLE on 17.12.2023.
//

import UIKit

extension UITextField {
    
    func addBottomBorder(height: CGFloat = 0.3, color: UIColor = .gray) {
        
        let bottomIndent: CGFloat = 5
        
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        borderView.layer.shadowOpacity = 0.2
        borderView.layer.shadowRadius = 3.0
        self.addSubview(borderView)
        
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomIndent),
            borderView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
