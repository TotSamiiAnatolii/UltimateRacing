//
//  ModelSetting.swift
//  UltimateRacing
//
//  Created by APPLE on 17.12.2023.
//

import UIKit

struct ModelSettingDTO {
    var header: ModelMainHeader?
    let sections: [TypeDataSection]
}

struct TypeDataSection {
    let title: String
    let rows: [TypeDataRow]
    
    init(_ title: String, rows: [TypeDataRow]) {
        self.title = title
        self.rows = rows
    }
}

enum TypeDataRow {
    
    enum Corners {
        case auto
        case bottom
    }
    
    case nameUser(ModelNameUserCell, Corners)
    case carSelection([ModelCarSelectionCell], Corners)
    case level(ModelGameDifficultyLevel, Corners)
    case control(ModelSelectControl, Corners)
}

extension TypeDataRow {
    
    var rowHeight: CGFloat {
        switch self {
        case .nameUser:
            return 44
        case .carSelection:
            return 200
        case .level:
            return 44
        case .control:
            return 44
        }
    }
}

enum RoundCornerCell {
    
    case full
    case top
    case bottom
    case none
}

extension RoundCornerCell: RawRepresentable {
    
    typealias RawValue = UIRectCorner
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case [.topLeft, .topRight, .bottomLeft, .bottomRight]: self = .full
        case [.topLeft, .topRight]: self = .top
        case [.bottomLeft, .bottomRight]: self = .bottom
        default: return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .full: return [.topLeft, .topRight, .bottomLeft, .bottomRight]
        case .top: return [.topLeft, .topRight]
        case .bottom: return [.bottomLeft, .bottomRight]
        case .none: return []
        }
    }
}

enum LastSelectedIndex {
    case levelLastSelectedIndexPath(IndexPath)
    
    case controlLastSelectedIndexPath(IndexPath)
}
