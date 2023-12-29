//
//  Mapper.swift
//  UltimateRacing
//
//  Created by APPLE on 23.12.2023.
//

import UIKit

final class SettingGameMapper {
    
    private let storageManager = StorageManager()
    
    func map(model: ModelSetting, colorCar: [UIColor], completion: @escaping ((TypeCompletion) -> Void)) -> ModelSettingDTO {
        
        ModelSettingDTO(
            header: ModelMainHeader(
                onAction: {
                    completion(.photo)
                },
                poster: storageManager.loadImage(name: model.photoUser) ?? Images.stab
            ),
            sections: [
                TypeDataSection("Name", rows: [
                    .nameUser(ModelNameUserCell(onAction: { name in
                        completion(.name(name))
                    }, name: model.nameUser), .bottom),
                ]),
                
                TypeDataSection("Car Selection", rows: [
                    .carSelection(colorCar.map({ color in
                        ModelCarSelectionCell(carColor: color)
                    }), .bottom),
                ]),
                TypeDataSection(
                    "Level",
                    rows: [.level(ModelGameDifficultyLevel(levelName: GameDifficultyLevel.easy.nameLavel,
                                                           state: model.lavel == .easy), .bottom),
                           
                        .level(ModelGameDifficultyLevel(levelName: GameDifficultyLevel.middle.nameLavel,
                                                        state: model.lavel == .middle), .bottom),
                           
                        .level(ModelGameDifficultyLevel(levelName: GameDifficultyLevel.hard.nameLavel,
                                                        state: model.lavel == .hard), .bottom)]),
                TypeDataSection(
                    "Control",
                    rows: [.control(ModelSelectControl(nameControl: TypeControl.swipe.nameControl,
                                                       state: model.type == .swipe), .bottom),
                           
                        .control(ModelSelectControl(nameControl: TypeControl.tap.nameControl,
                                                    state: model.type == .tap), .bottom)]
                    
                )
            ]
        )
    }
}

enum TypeCompletion {
    
    case photo
    case name(String)
}
