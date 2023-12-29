//
//  UserDefaultsManager.swift
//  UltimateRacing
//
//  Created by APPLE on 23.12.2023.
//

import UIKit

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    func saveUserSetting(data: ModelSetting) {
        
        if  let dataSetting = try? PropertyListEncoder().encode(data) {
            defaults.set(dataSetting, forKey: "UserSetting")
        }
    }
    
    func featchUserSetting() -> ModelSetting {
        
        guard let data = defaults.value(forKey: "UserSetting") as? Data,
              let model = try? PropertyListDecoder().decode(ModelSetting.self, from: data) else {
            return createStartSetting()
        }
        return model
    }
    
    func saveResultGame(_ data: ModelResultGame)  {
        
        var results = featchResultGame()
        
        results.append(data)
        
        if  let dataSetting = try? PropertyListEncoder().encode(results) {
            defaults.set(dataSetting, forKey: "ResultGame")
        }
    }
    
    func featchResultGame() -> [ModelResultGame] {
        
        guard let data = defaults.value(forKey: "ResultGame") as? Data,
              let model = try? PropertyListDecoder().decode([ModelResultGame].self, from: data) else {
            return []
        }
        return model
    }
    
    func createStartSetting() -> ModelSetting {
        
        ModelSetting(nameUser: "",
                     photoUser: "",
                     carColor: .red,
                     lavel: .easy,
                     type: .swipe)
    }
    
    func firstLaunch() {
        let settingForGame = createStartSetting()
        self.saveUserSetting(data: settingForGame)
    }
    
    func propertyListValue<Value: Decodable>(forKey key: String) -> Value? {
        guard let data = defaults.value(forKey: key) as? Data,
              let value = try? PropertyListDecoder().decode(Value.self, from: data)
        else {
            return nil
        }
        return value
    }
}

extension UserDefaultsManager {
    
    var userSettings: ModelSetting {
        get {
            guard let value: ModelSetting = propertyListValue(forKey: "UserSetting") else {
                return createStartSetting()
            }
            return value
        }
        set {
            guard let dataSetting = try? PropertyListEncoder().encode(newValue) else {
                return
            }
            defaults.set(dataSetting, forKey: "UserSetting")
        }
    }
}
