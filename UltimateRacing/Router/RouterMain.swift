//
//  RouterMain.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

protocol RouterMain {
    
    var navigationController: UINavigationController { get set }
    var assemblyBuilder: AssemblyBuilderProtocol { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showGameRacing()
    func showRecords()
    func showSetting()
    func popToRoot()
    func dismiss()
    func showImagePicker(_ sourceType: UIImagePickerController.SourceType, view: SettingPresenter)
    func alert(title: String, message: String, button: [UIAlertAction], preferredStyle: UIAlertController.Style)
}

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController
    
    var assemblyBuilder: AssemblyBuilderProtocol
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        let main = assemblyBuilder.createMainList(router: self)
        navigationController.viewControllers = [main]
    }
    
    func showGameRacing() {
        let view = assemblyBuilder.createGameScreen(router: self)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showRecords() {
        let view = assemblyBuilder.createRecordScreen(router: self)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showSetting() {
        let view = assemblyBuilder.createSettingsScreen(router: self)
        navigationController.pushViewController(view, animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    func showImagePicker(_ sourceType: UIImagePickerController.SourceType, view: SettingPresenter) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            return
        }
        let photoPicker = UIImagePickerController()
        photoPicker.sourceType = sourceType
        photoPicker.delegate = view
        photoPicker.allowsEditing = false
        navigationController.present(photoPicker, animated: true, completion: nil)
    }
    
    func alert(title: String, message: String, button: [UIAlertAction], preferredStyle: UIAlertController.Style) {
        let alertController = assemblyBuilder.createAlert(
            title: title,
            message: message,
            button: button,
            preferredStyle: preferredStyle)
        navigationController.present(alertController, animated: true)
    }
}
