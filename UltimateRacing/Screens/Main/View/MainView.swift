//
//  MainView.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

final class MainView: UIView {
    
    //MARK: - Properties
    
    private var onAction: ((ButtonType)->Void)?
    
    private let headingIndent: CGFloat = 50
    
    private let headerLabel = UILabel()
        .setMyStyle(
            numberOfLines: 2,
            textAlignment: .left,
            font: Fonts.header)
    
    private lazy var startButton = MyButton()
        .setMyStyle(backgroundColor: .white)
        .setShadow()
        .setTarget(method: #selector(actionButton),
                   target: self,
                   event: .touchUpInside)
    
    private lazy var settingButton = MyButton()
        .setMyStyle(backgroundColor: .white)
        .setShadow()
        .setTarget(method: #selector(actionButton),
                   target: self,
                   event: .touchUpInside)
    
    private lazy var recordButton = MyButton()
        .setMyStyle(backgroundColor: .white)
        .setShadow()
        .setTarget(method: #selector(actionButton),
                   target: self,
                   event: [.touchUpInside])
    
    private let horizontalStack = UIStackView()
        .myStyleStack(
            spacing: 15,
            alignment: .fill,
            axis: .horizontal,
            distribution: .fill,
            userInteraction: true)
    
    private let containerForButton = UIStackView()
        .myStyleStack(
            spacing: 15,
            alignment: .fill,
            axis: .vertical,
            distribution: .equalCentering,
            userInteraction: true)
    
    //MARK: - Init
    
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
        horizontalStack.addArrangedSubview(recordButton)
        horizontalStack.addArrangedSubview(settingButton)
        containerForButton.addArrangedSubview(horizontalStack)
        containerForButton.addArrangedSubview(startButton)
        
        self.addSubview(headerLabel)
        self.addSubview(containerForButton)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            recordButton.heightAnchor.constraint(equalToConstant: AppDesign.recordButtonHeight),
        ])
        
        NSLayoutConstraint.activate([
            settingButton.heightAnchor.constraint(equalToConstant: AppDesign.settingButtonHeight),
            settingButton.widthAnchor.constraint(equalTo: containerForButton.widthAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: AppDesign.startButtonHeight),
        ])
        
        NSLayoutConstraint.activate([
            containerForButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            containerForButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: headingIndent),
            containerForButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    @objc func actionButton(sender: UIButton) {
        
        switch sender {
        case startButton:
            onAction?(.start)
        case settingButton:
            onAction?(.setting)
        case recordButton:
            onAction?(.record)
        default:
            break
        }
    }
}
extension MainView: ConfigurableView {
    
    typealias Model = ModelMainView
    
    func configure(with model: Model) {
        
        self.onAction = model.onAction
        self.headerLabel.text = model.header
        self.settingButton.configure(with: ModelButton(
            title: "",
            image: Images.buttonSetting, font: nil))
        
        self.startButton.configure(with: ModelButton(
            title: model.buttonStartLabel,
            image: nil, font: Fonts.startButton))
        
        self.recordButton.configure(with: ModelButton(
            title: model.buttonStatisticsLabel,
            image: nil, font: Fonts.recordButton))
    }
}
