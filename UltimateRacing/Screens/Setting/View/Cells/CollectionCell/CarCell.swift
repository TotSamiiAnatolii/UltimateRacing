//
//  CarCell.swift
//  UltimateRacing
//
//  Created by APPLE on 17.12.2023.
//

import UIKit

final class CarCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static var identifire: String {"\(Self.self)"}
    
    private let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupCornerRadius()
    }
    
    private func setupCornerRadius() {
        layer.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: AppDesign.mainCornerRadius)
        layer.masksToBounds = true
    }
    
    private func setViewHierarhies() {
        contentView.addSubview(colorView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: self.topAnchor),
            colorView.leftAnchor.constraint(equalTo: self.leftAnchor),
            colorView.rightAnchor.constraint(equalTo: self.rightAnchor),
            colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
extension CarCell: ConfigurableView {
    
    func configure(with model: ModelCarSelectionCell) {
        colorView.backgroundColor = model.carColor
    }
    
    typealias Model = ModelCarSelectionCell
}
