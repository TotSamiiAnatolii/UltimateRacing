//
//  MyCustomLayout.swift
//  UltimateRacing
//
//  Created by APPLE on 30.11.2023.
//

import UIKit

final class MyCompositionalLayout {
    
    func setCurrentGoalsFlowLayout() -> UICollectionViewLayout {
        
        let itemsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let items = NSCollectionLayoutItem(layoutSize: itemsSize)
    
        let groupsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.36))
        
        let groups = NSCollectionLayoutGroup.horizontal(layoutSize: groupsSize, subitem: items, count: 1)
        
        let section = NSCollectionLayoutSection(group: groups)
        
        section.interGroupSpacing = 18
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20)
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind:  UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        ]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
