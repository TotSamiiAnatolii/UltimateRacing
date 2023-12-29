//
//  RecordsView.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

final class RecordsView: UIView {
    
    //MARK: Properties
    
    private var onBackButton: (()->Void)?
    
    public var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = Colors.mainBackgroundColor
        collectionView.clipsToBounds = false
        collectionView.allowsMultipleSelection = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView.register(RecordCell.self, forCellWithReuseIdentifier: RecordCell.identifire)
        return collectionView
    }()
 
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackgroundColor
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setViewHierarhies() {
        self.addSubview(collectionView)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc func backButtonAction() {
        onBackButton?()
    }
}
