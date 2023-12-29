//
//  SettingView.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

final class SettingView: UIView {
    
    //MARK: - Properties
    
    public var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.mainBackgroundColor
        tableView.register(NameUserCell.self, forCellReuseIdentifier: NameUserCell.identifire)
        tableView.register(CarSelectionCell.self, forCellReuseIdentifier: CarSelectionCell.identifire)
        tableView.register(GeneralCell.self, forCellReuseIdentifier: GeneralCell.identifire)
        return tableView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
        setViewHierarhies()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func prepareView() {
        backgroundColor = Colors.mainBackgroundColor
    }
    
    private func setViewHierarhies() {
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
