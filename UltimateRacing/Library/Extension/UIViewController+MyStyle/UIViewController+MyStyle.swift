//
//  UIViewController+MyStyle.swift
//  UltimateRacing
//
//  Created by APPLE on 29.11.2023.
//

import UIKit

extension UIViewController {
    
    func setupNavigationBar(leftItem: UIBarButtonItem?, rightItem: UIBarButtonItem?, titleView: UIView?) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Colors.mainBackgroundColor
        
        appearance.setBackIndicatorImage(
            Images.backButton,
            transitionMaskImage: Images.backButton
        )
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.rightBarButtonItem = rightItem
        navigationItem.titleView = titleView
        navigationController?.navigationBar.tintColor = .black
    }
}
