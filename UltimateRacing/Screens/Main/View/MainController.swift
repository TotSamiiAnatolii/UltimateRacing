//
//  MainController.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {}

final class MainController: UIViewController {
    
    //MARK: - Properties
    
    private let presenter: MainPresenterProtocol
    
    fileprivate var mainView: MainView {
        guard let view = self.view as? MainView else {
            return MainView()
        }
        return view
    }
    
    //MARK: - Init
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        self.view = MainView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        mainView.configure(with: MainView.Model(
            onAction: { [weak self] type in
                self?.onAction(type)
            }))
    }
    
    //MARK: - Private methods
    
    private func onAction(_ type: ButtonType) {
        presenter.showScreen(type)
    }
}
extension MainController: MainViewProtocol {}


