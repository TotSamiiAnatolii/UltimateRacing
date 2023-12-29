//
//  MainPresenter.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import Foundation

protocol MainPresenterProtocol {
    
    init(router: RouterProtocol)
        
    func showScreen(_ type: ButtonType)

}

final class MainPresenter: MainPresenterProtocol {
    
    //MARK: - Properties
    
    private var router: RouterProtocol
    
    weak var view: MainViewProtocol?
     
    //MARK: - Init
    
    init(router: RouterProtocol) {
        self.router = router
    }
  
    func showScreen(_ type: ButtonType) {
        switch type {
        case .start:
            router.showGameRacing()
        case .record:
            router.showRecords()
        case .setting:
            router.showSetting()
        }
    }
}
