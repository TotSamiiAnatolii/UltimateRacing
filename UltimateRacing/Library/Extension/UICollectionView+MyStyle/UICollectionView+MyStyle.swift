//
//  File.swift
//  UltimateRacing
//
//  Created by APPLE on 23.12.2023.
//

import UIKit

protocol CollectionVisibleMidCell {}

extension CollectionVisibleMidCell where Self: UICollectionView {

    func getMidVisibleIndexPath() -> Int? {
        
        var visibleRect = CGRect()
        visibleRect.origin = self.contentOffset
        visibleRect.size = self.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = self.indexPathForItem(at: visiblePoint) else { return nil }
        return indexPath.row
    }
}

extension UICollectionView: CollectionVisibleMidCell {}
