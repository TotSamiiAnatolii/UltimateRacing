//
//  RecordPresenter.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import Foundation

protocol RecordsPresenterProtocol {
    
    init(router: RouterProtocol)
   
    func viewDidLoad()
    
    func fetchRecords()
}

final class RecordsPresenter: RecordsPresenterProtocol {
  
    //MARK: - Properties
    
    private var router: RouterProtocol
    
    weak var view: RecordsViewProtocol?
    
    private var resultGame: [ModelResultGame] = []
    
    //MARK: - Init
    
    init(router: RouterProtocol) {
        self.router = router
        fetchRecords()
    }
    
    func viewDidLoad() {
        view?.succes(resultGame)
    }
    
    func fetchRecords() {
        resultGame = UserDefaultsManager.shared.featchResultGame()
    }
}
