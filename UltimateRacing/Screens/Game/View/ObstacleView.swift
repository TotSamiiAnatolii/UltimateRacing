//
//  ObstacleView.swift
//  UltimateRacing
//
//  Created by APPLE on 10.12.2023.
//

import UIKit

final class ObstacleView: UIView {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        backgroundColor = .black
        layer.cornerRadius = 10
    }
}
