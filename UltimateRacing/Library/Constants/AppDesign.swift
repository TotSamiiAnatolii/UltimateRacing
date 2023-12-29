//
//  AppDesign.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

enum AppDesign {
    
    static let mainCornerRadius: CGFloat = 15
    
    static let indent: CGFloat = 15
    
    static let offset: CGFloat = -15
    
    static let cornerRadiusStatistic: CGFloat = 25
    
    static let dashSize: NSNumber = 90
    
    static let gapSize: NSNumber = 50
    
    static let startButtonHeight: CGFloat = 60
    
    static let settingButtonHeight: CGFloat = 50
    
    static let recordButtonHeight: CGFloat = 50
    
    static let photoUserHeight: CGFloat = 64
    
    static let photoUserWidth: CGFloat = 64
    
    static let lineWidth: CGFloat = 12
    
    static let addPhotoUserButton: (height: CGFloat, width: CGFloat) = (height: 148, width: 148)
    
    static func widthCar(_ view: UIView) -> CGFloat {
        (view.frame.size.width / 2) * 0.8
    }
    
    static func heightCar(_ view: UIView) -> CGFloat {
         view.bounds.size.height / 7
    }
    
    static func leftRoad(_ view: UIView) -> CGFloat {
        ((view.frame.minX + view.frame.midX)) / 2
    }
    
    static func rightRoad(_ view: UIView) -> CGFloat  {
        (view.frame.maxX + (view.frame.midX + (lineWidth/2))) / 2
    }
}
