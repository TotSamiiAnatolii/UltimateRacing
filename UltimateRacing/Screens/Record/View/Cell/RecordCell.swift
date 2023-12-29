//
//  RecordCell.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

final class RecordCell: UICollectionViewCell {

    //MARK: - Properties
    
    static var identifire: String {"\(Self.self)"}
    
    private let photoUser = UIImageView()
        .setMyStyle()
    
    private let nameUserLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .right,
            font: UIFont.systemFont(ofSize: 17, weight: .semibold))
        .setTextColor(color: Colors.textColor)
    
    private let dateGame = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .right,
            font: UIFont.preferredFont(forTextStyle: .title1).withSize(13))
        .setTextColor(color: Colors.textColor)

    private let recordGame = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .right,
            font: UIFont.preferredFont(forTextStyle: .title1).withSize(13))
        .setTextColor(color: Colors.textColor)
    
    private let horizontalStack = UIStackView()
        .myStyleStack(
            spacing: 15,
            alignment: .center,
            axis: .horizontal,
            distribution: .equalSpacing,
            userInteraction: false)
        .setLayoutMargins(top: 10, left: 10, bottom: 10, right: 5)
    
    private let verticalStack = UIStackView()
        .myStyleStack(
            spacing: 5,
            alignment: .leading,
            axis: .vertical,
            distribution: .equalSpacing,
            userInteraction: false)
   
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewHierarhies()
        setupConstraints()
        configureVeiw()
        setupCornerRadiusCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? touchDown() : touchUp()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoUser.image = nil
        nameUserLabel.text = nil
        recordGame.text = nil
        dateGame.text = nil
    }
    
    //MARK: - Private methods
    
    private func setViewHierarhies() {
        verticalStack.addArrangedSubview(nameUserLabel)
        verticalStack.addArrangedSubview(recordGame)
        verticalStack.addArrangedSubview(dateGame)
        horizontalStack.addArrangedSubview(photoUser)
        horizontalStack.addArrangedSubview(verticalStack)
        contentView.addSubview(horizontalStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            horizontalStack.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            photoUser.widthAnchor.constraint(equalToConstant: AppDesign.photoUserHeight),
            photoUser.heightAnchor.constraint(equalToConstant: AppDesign.photoUserWidth),
        ])
    }
    
    private func touchDown() {
        let scaleX = 0.98
        let scaleY = 0.98
        
        transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    }
    
    private func  touchUp() {
        let scaleX = 1.0
        let scaleY = 1.0
        
        UIView.animateKeyframes(withDuration: 0.4,
                                delay: 0,
                                options: [.beginFromCurrentState,
                                          .allowUserInteraction],
                                animations: {
            
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        })
    }
    
    private func configureVeiw() {
        contentView.backgroundColor = Colors.backgroundCell
    }
    
    private func setupCornerRadiusCell() {
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
    }
    
    private func setupShadowCell() {
        let radius: CGFloat = 20
        layer.shadowColor = #colorLiteral(red: 0.8201048466, green: 0.8201048466, blue: 0.8201048466, alpha: 1)
        layer.shadowOffset = CGSize(width: 1, height: 3)
        layer.shadowRadius = 7.0
        layer.shadowOpacity = 1
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
extension RecordCell: ConfigurableView {
    func configure(with model: ModelResultGame) {
        photoUser.loadImage(model.user.photoUser)
        nameUserLabel.text = model.user.nameUser
        recordGame.text = "Result: \(model.count)"
        dateGame.text = DateFormatter.formatDate(date: model.date)
    }
    
    typealias Model = ModelResultGame
}
