//
//  ViewController.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

protocol RecordsViewProtocol: AnyObject {
    
    func succes(_ models: [ModelResultGame])
}

final class RecordsController: UIViewController {
    
    fileprivate var recordView: RecordsView {
        guard let view = self.view as? RecordsView else {
            return RecordsView()
        }
        return view
    }
    
    private var models: [ModelResultGame] = []
    
    private let myCompositionalLayout = MyCompositionalLayout()
    
    private let mainTitle = "Record"
    
    private let presenter: RecordsPresenterProtocol
  
    //MARK: - Init
    init(presenter: RecordsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = RecordsView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        presenter.viewDidLoad()
        recordView.collectionView.delegate = self
        recordView.collectionView.dataSource = self
        recordView.collectionView.collectionViewLayout = myCompositionalLayout.setCurrentGoalsFlowLayout()
    }
    
    //MARK: - Configure view components
    private func configureNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = mainTitle
        titleLabel.font = Fonts.mainTitle
        titleLabel.textColor = .black
        setupNavigationBar(leftItem: nil, rightItem: nil, titleView: titleLabel)
    }
}

extension RecordsController: RecordsViewProtocol {
    
    func succes(_ models: [ModelResultGame]) {
        self.models = models
        recordView.collectionView.reloadData()
    }
}

extension RecordsController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCell.identifire, for: indexPath) as? RecordCell else {
            return UICollectionViewCell()
        }
        if indexPath.section < models.count {
            cell.configure(with: models[indexPath.row])
        }
        return cell
    }
}
