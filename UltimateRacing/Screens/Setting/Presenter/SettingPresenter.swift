//
//  SettingPresenter.swift
//  UltimateRacing
//
//  Created by APPLE on 27.11.2023.
//

import UIKit

protocol SettingPresenterProtocol {
    
    init(router: RouterProtocol)
    
    var mainTitle: String { get }
    
    func viewDidLoad()
 
    func loadSettingForGame()
    
    func saveSettingForGame()
    
    func addPhotoUser()
    
    func addNameUser(_ name: String)
  
    func updateCarColor(_ color: UIColor)
    
    func updatePhotoUser(_ photo: UIImage)
    
    func indexForColorCar() -> IndexPath
    
    func setSelectedCell(_ typeDataRow: TypeDataRow, indexPath: IndexPath, levelSelected: IndexPath, controlSelected: IndexPath)
}

final class SettingPresenter: NSObject, SettingPresenterProtocol {
  
    //MARK: - Properties
    
    private var router: RouterProtocol
    
    weak var view: SettingViewProtocol?
    
    var mainTitle = "Settings"
    
    private var modelSetting: ModelSetting?
       
    var model: ModelSettingDTO? {
        didSet {
            guard let model else { return }
            view?.success(model: model)
        }
    }
    
    private let storageManager = StorageManager()
    
    private let mapper = SettingGameMapper()
    
    private let colorCar: [UIColor] = [.brown, .systemGray, .red, .brown, .systemGray, .red]
    
    //MARK: - Init
    
    init(router: RouterProtocol) {
        self.router = router
        super.init()
        self.loadSettingForGame()
    }
    
    func viewDidLoad() {
        guard let modelSetting else {return}
        self.model = mapper.map(model: modelSetting, colorCar: colorCar, completion: { [weak self] type in
            
            switch type {
            case .photo:
                self?.addPhotoUser()
            case let .name(name):
                self?.addNameUser(name)
            }
        })
    }
    
    func loadSettingForGame() {
        modelSetting = UserDefaultsManager.shared.featchUserSetting()
    }
    
    func saveSettingForGame() {
        guard let model = modelSetting else { return }
        UserDefaultsManager.shared.saveUserSetting(data: model)
    }
    
    func addPhotoUser() {
        let cameraButton = UIAlertAction(title: "Camera", style: .default) { _ in
            self.router.showImagePicker(.camera, view: self)
        }
        
        let libraryButton = UIAlertAction(title: "Library", style: .default) { _ in
            self.router.showImagePicker(.photoLibrary, view: self)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .default)
        
        router.alert(title: "Select Image",
                     message: "Select image from",
                     button: [cameraButton, libraryButton, cancelButton],
                     preferredStyle: .actionSheet)
    }
  
    func updateCarColor(_ color: UIColor) {
        modelSetting?.carColor = color
    }
    
    func updatePhotoUser(_ photo: UIImage) {
        do{
            try modelSetting?.photoUser = self.storageManager.saveImage(photo) ?? ""
        }
        catch {
            print(error)
        }
    }
    
    func addNameUser(_ name: String) {
        modelSetting?.nameUser = name
    }
    
     func indexForColorCar() -> IndexPath {
        let row = Int (colorCar.firstIndex(where: { $0 == modelSetting?.carColor }) ?? 0 )
        return IndexPath(row: row, section: 0)
    }
    
    func setSelectedCell(_ typeDataRow: TypeDataRow, indexPath: IndexPath, levelSelected: IndexPath, controlSelected: IndexPath) {
        switch typeDataRow {

        case .level:
            modelSetting?.lavel = GameDifficultyLevel.allCases[indexPath.row]
            view?.updateCell(accessoryType: .none, indexPath: levelSelected, lastSelected: .levelLastSelectedIndexPath(indexPath))
            
        case .control:
            modelSetting?.type = TypeControl.allCases[indexPath.row]
            view?.updateCell(accessoryType: .none, indexPath: controlSelected, lastSelected: .controlLastSelectedIndexPath(indexPath))
            
        default:
            break
        }
    }
 
}
extension SettingPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        model?.header?.poster = image
        view?.updateMainHeaderView(model: model?.header)
        updatePhotoUser(image)
        picker.dismiss(animated: true)
    }
}
