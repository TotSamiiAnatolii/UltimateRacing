//
//  MainHeader.swift
//  UltimateRacing
//
//  Created by APPLE on 17.12.2023.
//
import UIKit

final class MainHeader: UIView {
    
    //MARK: - Properties
    
    private var onAction: (() -> Void)?
    
    private lazy var addPhotoUserButton: UIButton = UIButton()
        .setStyle()
        .setRoundCorners(radius: AppDesign.mainCornerRadius)
        .setTarget(method: #selector(addPhotoUserAction),
                   target: self,
                   event: .touchUpInside)
    
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
        backgroundColor = Colors.mainBackgroundColor
    }
    
    private func setViewHierarhies() {
        addSubview(addPhotoUserButton)
    }
    
    private func setupConstaints() {
        
        NSLayoutConstraint.activate([
            addPhotoUserButton.widthAnchor.constraint(equalToConstant: AppDesign.addPhotoUserButton.width),
            addPhotoUserButton.heightAnchor.constraint(equalToConstant: AppDesign.addPhotoUserButton.height),
            addPhotoUserButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addPhotoUserButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    @objc func addPhotoUserAction() {
        onAction?()
    }
}
extension MainHeader: ConfigurableView {
    
    typealias Model = ModelMainHeader
    
    func configure(with model: Model) {
        self.onAction = model.onAction
        addPhotoUserButton.setImage(model.poster, for: .selected)
        addPhotoUserButton.setImage(model.poster, for: .normal)
    }
}
