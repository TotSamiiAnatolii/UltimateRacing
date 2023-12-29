//
//  GeneralCell.swift
//  UltimateRacing
//
//  Created by APPLE on 17.12.2023.
//

import UIKit

final class GeneralCell: UITableViewCell, CornerRadiusConfigurable {
    
    //MARK: - Properties
    
    static var identifire: String {"\(Self.self)"}
    
    private var onAction: (() -> Void)?
    
    private let nameLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: .systemFont(ofSize: 15))
        .setTextColor(color: .blue)
    
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        accessoryType = .none
        layer.roundCorners(.allCorners, radius: 0.0)
    }
    
    //MARK: - Private methods
    
    private func setViewHierarhies() {
        contentView.addSubview(nameLabel)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppDesign.indent),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: AppDesign.offset),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    //MARK: - Public methods
    
    public func setRoundCorner(state: RoundCornerCell, radius: CGFloat) {
        layer.roundCorners(state.rawValue, radius: radius)
        layer.masksToBounds = true
    }
}
extension GeneralCell: ConfigurableView {
    
    typealias Model = ModelGeneralCell
    
    func configure(with model: Model) {
        nameLabel.text = model.name
    }
}


