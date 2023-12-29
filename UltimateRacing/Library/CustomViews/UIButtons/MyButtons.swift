//
//  MyButtons.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

struct ModelButton {
    let title: String
    let image: UIImage?
    let font: UIFont?
}

final class MyButton: UIButton {
    
    override var isHighlighted: Bool {
        
        didSet {
            if isHighlighted {
                touchDown()
            } else {
                touchUp()
            }
        }
    }
    
    private let myTitleLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .center,
            font: Fonts.fontForButton)

    private let myImage = UIImageView()
        .setMyStyle()
    
    private let containerForButton = UIStackView()
        .myStyleStack(
            spacing: 4,
            alignment: .center,
            axis: .horizontal,
            distribution: .equalSpacing,
            userInteraction: false)
        .setLayoutMargins(top: 5, left: 5, bottom: 5, right: 5)
    
    private func touchDown() {
        let scaleX = 0.98
        let scaleY = 0.98

        self.myTitleLabel.alpha = 0.5
        self.myImage.alpha = 0.5
        self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarhies()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarhies() {
        self.addSubview(containerForButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if myImage.image == nil {
            containerForButton.addArrangedSubview(myTitleLabel)

        } else {
            containerForButton.addArrangedSubview(myTitleLabel)
            containerForButton.addArrangedSubview(myImage)
        }
    }
    
    private func setConstraints() {

        NSLayoutConstraint.activate([
            containerForButton.topAnchor.constraint(equalTo: self.topAnchor),
            containerForButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            containerForButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            containerForButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func touchUp() {
        let scaleX = 1.0
        let scaleY = 1.0
        
        UIView.animateKeyframes(withDuration: 0.4,
                                delay: 0,
                                options: [.beginFromCurrentState,
                                          .allowUserInteraction],
                                animations: {
            self.myTitleLabel.alpha = 1
            self.myImage.alpha = 1
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        })
    }
}
extension MyButton: ConfigurableView {
    typealias Model = ModelButton
    
    func configure(with model: ModelButton) {
        self.myTitleLabel.font = model.font
        self.myTitleLabel.text = model.title
        self.myImage.image = model.image
    }
}
