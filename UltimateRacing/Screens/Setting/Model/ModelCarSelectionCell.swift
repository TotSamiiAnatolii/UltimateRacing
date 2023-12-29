//
//  ModelCarSelectionCell.swift
//  UltimateRacing
//
//  Created by APPLE on 17.12.2023.
//

import UIKit

struct ModelCarSelection {
    
    let onAction: (() -> Void)
    
    let carColorCell: [ModelCarSelectionCell]
    
 }

struct ModelCarSelectionCell {
    
    let carColor: UIColor
}
