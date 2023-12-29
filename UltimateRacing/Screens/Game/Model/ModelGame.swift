//
//  ModelGame.swift
//  UltimateRacing
//
//  Created by APPLE on 03.12.2023.
//

import Foundation

enum TrafficLanes: CaseIterable {
    case left
    case right
}

enum Boundary: String {
    case carBoudary = "CarBottomBoundary"
    case bottomBoundary = "BottomBoundary"
}

enum GameDifficultyLevel:  Codable, CaseIterable {
    case easy
    case middle
    case hard
    
    var nameLavel: String {
        switch self {
        case .easy:
            return "Easy"
        case .middle:
            return "Middle"
        case .hard:
            return "Hard"
        }
    }
    
    var speed: (speed: Float, magnitude: Double) {
        switch self {
        case .easy:
            return (1, 0.1)
        case .middle:
            return (2, 0.3)
        case .hard:
            return (3, 1)
        }
    }
}

struct GameViewSetup {
    
    let speed: Float
    let magnitude: Double
}

enum TypeControl: Codable, CaseIterable {
    case swipe
    case tap
    
    var nameControl: String {
        switch self {
        case .swipe:
            return "Swipe"
        case .tap:
            return "Tap"
        }
    }
}
