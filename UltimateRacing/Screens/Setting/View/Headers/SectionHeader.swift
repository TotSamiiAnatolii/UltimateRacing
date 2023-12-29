//
//  SectionHeader.swift
//  UltimateRacing
//
//  Created by APPLE on 17.12.2023.
//

import UIKit

final class SectionHeader: UIView {
    
    //MARK: - Properties
    
    private let titleLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.headerSettingSection)
        .setTextColor(color: .black)

    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setViewHierarhies()
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        backgroundColor = .white
        roundCorners([.topLeft, .topRight], radius: 15)
    }
    
    private func setViewHierarhies() {
        self.addSubview(titleLabel)
    }
    
    private func setupConstaints() {
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: AppDesign.indent),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
extension SectionHeader: ConfigurableView {
    
    typealias Model = ModelHeader
    
    func configure(with model: ModelHeader) {
        titleLabel.text = model.title
    }
}

