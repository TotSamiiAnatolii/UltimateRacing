//
//  CarSelectionCell.swift
//  UltimateRacing
//
//  Created by APPLE on 17.12.2023.
//

import UIKit

protocol CarSelectionColorDelegate: AnyObject {
    
    func updateCarColor(_ color: UIColor)
}

final class CarSelectionCell: UITableViewCell, CornerRadiusConfigurable {

    //MARK: - Properties
    
    static var identifire: String {"\(Self.self)"}
    
    private var onAction: (() -> Void)?
    
    weak var delegate: (CarSelectionColorDelegate)?
    
    private var data: [ModelCarSelectionCell] = [] {
        didSet {
            collectionView.reloadData()
            layoutIfNeeded()
        }
    }
    
    public lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let layout = CustomCenteredLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
        collectionView.contentInset = UIEdgeInsets(top: .zero, left: AppDesign.indent, bottom: .zero, right: AppDesign.indent)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CarCell.self, forCellWithReuseIdentifier: CarCell.identifire)
        return collectionView
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViewHierarhies()
        setConstraints()
        prepareVeiw()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods
    
    private func setViewHierarhies() {
        contentView.addSubview(collectionView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: AppDesign.offset),
        ])
    }
    
    private func prepareVeiw() {
        backgroundColor = Colors.mainBackgroundColor
        contentView.backgroundColor = .white
        selectionStyle = .none
    }
    
    public func setRoundCorner(state: RoundCornerCell, radius: CGFloat) {
        contentView.roundCorners(state.rawValue, radius: radius)
    }
}

extension CarSelectionCell: ConfigurableView {
    func configure(with model: Model) {
        self.data = model
    }
    
    typealias Model = [ModelCarSelectionCell]
}

extension CarSelectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarCell.identifire, for: indexPath) as? CarCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: data[indexPath.row])
        return cell
    }
  
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
     
        guard let indexColor = collectionView.getMidVisibleIndexPath() else {
            return
        }
        
        delegate?.updateCarColor(data[indexColor].carColor)
    }
}
