//
//  GameRacingController.swift
//  UltimateRacing
//
//  Created by APPLE on 27.11.2023.
//

import UIKit

protocol GameRacingViewProtocol: AnyObject {
    
    func createObstacle()
    
    func startGame(_ settingForGame: ModelSetting)
    
    func counter(count: Int)
    
    func repeatGame(_ settingForGame: ModelSetting)
    
    func stopAnimation() 
}

final class GameRacingController: UIViewController {
    
    //MARK: - Properties
    
    private let presenter: GameRacingPresenterProtocol
    
    fileprivate var gameRacingView: GameRacingView {
      guard let view = self.view as? GameRacingView else {
            return GameRacingView()
        }
        return view
    }
    
    //MARK: - Init
    
    init(presenter: GameRacingPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        self.view = GameRacingView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        gameRacingView.collider.collisionDelegate = self
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }
    
    //MARK: - Configure view components
    
    private func configureNavigationBar(count: Int = 0) {
        let titleLabel = UILabel()
        titleLabel.text = "\(presenter.mainTitle)\(count)"
        titleLabel.font = Fonts.mainTitle
        titleLabel.textColor = .black
        setupNavigationBar(leftItem: nil, rightItem: nil, titleView: titleLabel)
    }
}

extension GameRacingController: GameRacingViewProtocol {

    func counter(count: Int) {
        configureNavigationBar(count: count)
    }
    
    func startGame(_ settingForGame: ModelSetting) {
        gameRacingView.changeSpeed(settingForGame)
    }
    
    func createObstacle() {
        gameRacingView.createObstacle()
    }
    
    func stopAnimation() {
        gameRacingView.stopGame()
    }
    
    func repeatGame(_ settingForGame: ModelSetting) {
        gameRacingView.repeatGame(settingForGame)
    }
}

extension GameRacingController: UICollisionBehaviorDelegate {
 
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        presenter.endGame()
    }

    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        
        guard let view = item as? UIView else {
            return
        }
        
        if let boundaryID = identifier as? String, boundaryID == Boundary.carBoudary.rawValue {
       
            if gameRacingView.car.frame.maxY < view.frame.minY {
                presenter.counter()
            }
        }
        
        if let boundaryID = identifier as? String, boundaryID == Boundary.bottomBoundary.rawValue {
       
            if view.frame.minY > gameRacingView.frame.height {
                if let view = view as? ObstacleView {
                    gameRacingView.removeObstacle(view)
                }
            }
        }
    }
}
