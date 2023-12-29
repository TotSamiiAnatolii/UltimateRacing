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
    
    private var resultGame: [ModelResultGame] = [] {
        didSet {
            view?.succes(resultGame) 
        }
    }
    
    //MARK: - Init
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func viewDidLoad() {
        fetchRecords()
    }
    
    func fetchRecords() {
        self.resultGame = UserDefaultsManager.shared.featchResultGame()
    }
}
