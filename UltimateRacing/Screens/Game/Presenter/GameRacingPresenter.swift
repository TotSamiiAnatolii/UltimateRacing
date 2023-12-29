//
//  GameRacingPresenter.swift
//  UltimateRacing
//
//  Created by APPLE on 27.11.2023.
//

import UIKit

protocol GameRacingPresenterProtocol {
    
    var mainTitle: String { get }
    
    init(router: RouterProtocol)
    
    func viewDidLoad()
    
    func startGame()
    
    func counter()
    
    func endGame()
    
    func repeatGame()
    
    func saveResultGame()
    
    func loadSettingGame()
}

final class GameRacingPresenter: GameRacingPresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: GameRacingViewProtocol?
    
    private var timer: Timer?
    
    private var settingForGame: ModelSetting?
    
    private var modelResultGame: ModelResultGame?
    
    private var router: RouterProtocol
    
    private let timeInterval = 0.5
    
    private var count = 0 {
        didSet {
            view?.counter(count: count)
        }
    }
    
    var mainTitle = "Счет: "
    
    //MARK: - Init
    
    init(router: RouterProtocol) {
        self.router = router
        loadSettingGame()
    }
    
    deinit {
        timerInvalidate()
    }
    
    //MARK: - Methods
    
    func viewDidLoad() {
        startGame()
    }
    
    func startGame() {
        guard let settingForGame else { return }
        
        view?.startGame(settingForGame)
        timerStart()
    }
    
    func counter() {
        count += 1
    }
    
    func repeatGame() {
        guard let settingForGame else { return }
        
        viewDidLoad()
        saveResultGame()
        view?.repeatGame(settingForGame)
        count = 0
    }
    
    func saveResultGame() {
        guard let modelResultGame else { return }
        
        UserDefaultsManager.shared.saveResultGame(modelResultGame)
    }
    
    func endGame() {
        showAlert()
        prepareResult()
        saveResultGame()
        view?.stopAnimation()
    }
    
    func loadSettingGame() {
        settingForGame = UserDefaultsManager.shared.featchUserSetting()
    }
    
    //MARK: - Private methods
    
    private func timerInvalidate() {
        timer?.invalidate()
    }
    
    private func timerStart() {
        DispatchQueue.global().sync {
            self.timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
                
                self?.view?.createObstacle()
            }
        }
    }
    
    private func prepareResult() {
        guard let settingForGame else { return }
        
        let resultGame = ModelResultGame(user: settingForGame, date: Date(), count: count)
        modelResultGame = resultGame
    }
    
    private func showAlert() {
        let repeatButton = UIAlertAction(title: "Repeat", style: .default) { _ in
            self.repeatGame()
        }
        
        let libraryButton = UIAlertAction(title: "End", style: .default) { _ in
            self.router.popToRoot()
        }
        
        router.alert(title: "ПОТРАЧЕНО",
                     message: "Твой счет: \(count)",
                     button: [repeatButton, libraryButton],
                     preferredStyle: .alert)
    }
}
