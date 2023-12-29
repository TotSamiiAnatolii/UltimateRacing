//
//  CALayer+Animation.swift
//  UltimateRacing
//
//  Created by APPLE on 02.12.2023.
//

import UIKit

extension CALayer {
    
    func pauseAnimation() {
        if isPaused() == false {
            let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
            timeOffset = pausedTime
        }
    }
    
    func resumeAnimation(_ speed: Float) {
        
        self.timeOffset = convertTime(CACurrentMediaTime(), from: nil)
        self.beginTime = CACurrentMediaTime()
        self.speed = speed
        
    }
    
    func isPaused() -> Bool {
        return speed == 0
    }
}
