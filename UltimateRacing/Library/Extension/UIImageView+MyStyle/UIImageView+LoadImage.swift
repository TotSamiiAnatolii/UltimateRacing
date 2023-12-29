//
//  UIImageView+LoadImage.swift
//  UltimateRacing
//
//  Created by APPLE on 29.12.2023.
//

import UIKit

extension UIImageView {
    
    func loadImage(_ url: String) {
        let storageManager = StorageManager()
        
        DispatchQueue.main.async {
            let photo = storageManager.loadImage(name: url)
            self.image = photo
        }
    }
}

