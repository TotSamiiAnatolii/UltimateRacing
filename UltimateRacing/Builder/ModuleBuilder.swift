//
//  ModuleBuilder.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    
    func createMainList(router: RouterProtocol) -> UIViewController
        
    func createGameScreen(router: RouterProtocol) -> UIViewController
    
    func createSettingsScreen(router: RouterProtocol) -> UIViewController

    func createRecordScreen(router: RouterProtocol) -> UIViewController
    
    func createAlert(title: String, message: String, button: [UIAlertAction], preferredStyle: UIAlertController.Style) -> UIAlertController
}


final class ModuleBuilder: AssemblyBuilderProtocol {
    
    func createMainList(router: RouterProtocol) -> UIViewController {
        let presenter = MainPresenter(router: router)
        let view = MainController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createGameScreen(router: RouterProtocol) -> UIViewController {
        let presenter = GameRacingPresenter(router: router)
        let view = GameRacingController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createSettingsScreen(router: RouterProtocol) -> UIViewController {
        let presenter = SettingPresenter(router: router)
        let view = SettingController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createRecordScreen(router: RouterProtocol) -> UIViewController {
        let presenter = RecordsPresenter(router: router)
        let view = RecordsController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createAlert(title: String, message: String, button: [UIAlertAction], preferredStyle: UIAlertController.Style) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        button.forEach { button in
            alertController.addAction(button)
        }
    
        return alertController
    }
}
