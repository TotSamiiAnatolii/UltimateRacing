//
//  Protocols.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import Foundation

protocol ConfigurableView {
    associatedtype Model
    
    func configure(with model: Model)
}

protocol CornerRadiusConfigurable {
    
    func setRoundCorner(state: RoundCornerCell, radius: CGFloat)
}
