//
//  NameUserCell.swift
//  UltimateRacing
//
//  Created by APPLE on 17.12.2023.
//

import UIKit

final class NameUserCell: UITableViewCell, CornerRadiusConfigurable {

    //MARK: - Properties
    
    static var identifire: String {"\(Self.self)"}
    
    private var onAction: ((String) -> Void)?
    
    private let placeholder = "User name"
    
    private let nameUserTextField: UITextField = UITextField()
        .setMyStyle(textAligment: .left,
                    font: UIFont.systemFont(ofSize: 19, weight: .semibold))
        
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureVeiw()
        setViewHierarhies()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameUserTextField.text = nil
    }
    
    //MARK: - Private methods
    
    private func configureVeiw() {
        contentView.backgroundColor = .white
        backgroundColor = Colors.mainBackgroundColor
        selectionStyle = .none
        nameUserTextField.addBottomBorder()
        nameUserTextField.placeholder = placeholder
        nameUserTextField.delegate = self
    }
    
    private func setViewHierarhies() {
        contentView.addSubview(nameUserTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameUserTextField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: AppDesign.indent),
            nameUserTextField.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: AppDesign.indent),
            nameUserTextField.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: AppDesign.offset),
            nameUserTextField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: AppDesign.offset)
        ])
    }
    
    //MARK: - Public methods
    public func setRoundCorner(state: RoundCornerCell, radius: CGFloat) {
        contentView.roundCorners(state.rawValue, radius: radius)
    }
}
extension NameUserCell: ConfigurableView {
    
    func configure(with model: Model) {
        self.nameUserTextField.text = model.name
        self.onAction = model.onAction
    }
    
    typealias Model = ModelNameUserCell
}

extension NameUserCell: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        onAction?(text)
    }
}
