//
//  SettingController.swift
//  UltimateRacing
//
//  Created by APPLE on 26.11.2023.
//

import UIKit

protocol SettingViewProtocol: AnyObject {
    
    func success(model: ModelSettingDTO)
    
    func updateCell(accessoryType: UITableViewCell.AccessoryType, indexPath: IndexPath, lastSelected: LastSelectedIndex)
    
    func updateMainHeaderView(model: ModelMainHeader?)
}

final class SettingController: UIViewController {
    
    //MARK: - Properties
    
    private let presenter: SettingPresenterProtocol
    
    private var model: ModelSettingDTO = ModelSettingDTO(header: nil, sections: [])
    
    fileprivate var settingView: SettingView {
        guard let view = self.view as? SettingView else {
            return SettingView()
        }
        return view
    }
    
    private var levelLastSelectedIndexPath: IndexPath = [0, 0]
    
    private var controlLastSelectedIndexPath: IndexPath = [0, 0]
    
    private let heightForHeaderInSection: CGFloat = 44
    
    private let heightForFooterInSection: CGFloat = 10
    
    //MARK: - Init
    
    init(presenter: SettingPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SettingView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        configureNavigationBar()
        presenter.viewDidLoad()
        prepareMainHeaderView(model: model.header)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.saveSettingForGame()
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = UILabel()
        titleLabel.text = presenter.mainTitle
        titleLabel.font = Fonts.mainTitle
        titleLabel.textColor = .black
        setupNavigationBar(leftItem: nil, rightItem: nil, titleView: titleLabel)
    }
    
    private func prepareTableView() {
        settingView.tableView.delegate = self
        settingView.tableView.dataSource = self
        settingView.tableView.contentInset.top = 20
        
        let contentOffsetY = -settingView.tableView.contentInset.top
        settingView.tableView.setContentOffset(CGPoint(x: .zero, y: contentOffsetY), animated: false)
    }
    
    private func prepareMainHeaderView(model: ModelMainHeader?) {
        if let headerModel = model {
            
            if settingView.tableView.tableHeaderView == nil {
                let widhtHeader = view.frame.width
                let heightHeader: CGFloat = view.frame.height * 0.2
                let header = MainHeader(frame: CGRect(x: 0, y: 0, width: widhtHeader, height: heightHeader))
                settingView.tableView.tableHeaderView = header
            }
            
            (settingView.tableView.tableHeaderView as? MainHeader)?.configure(with: headerModel)
        } else {
            settingView.tableView.tableHeaderView = nil
        }
        settingView.tableView.reloadData()
    }
    
    private func roundСornersCells(indexPath: IndexPath, _ tableView: UITableView) -> RoundCornerCell {
        
        let lastCellinSection = tableView.numberOfRows(inSection: indexPath.section) - 1
        
        switch indexPath.row {
            
        case _ where indexPath.row == lastCellinSection:
            return .bottom
            
        default:
            return .none
        }
    }
    
    private func setPositionSelectedCarColor(_ cell: CarSelectionCell) {
        let startPositionIndex = presenter.indexForColorCar()
        cell.collectionView.scrollToItem(at: startPositionIndex, at: .centeredHorizontally, animated: false)
    }
}
extension SettingController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < model.sections.count else {
            return 0 }
        
        return model.sections[section].rows.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return model.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.section < model.sections.count,
              indexPath.row < model.sections[indexPath.section].rows.count
        else {
            return UITableViewCell()
        }
        
        let rowItem = model.sections[indexPath.section].rows[indexPath.row]
        
        switch rowItem {
        case let .nameUser(model, _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NameUserCell.identifire, for: indexPath) as? NameUserCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
            
        case let .carSelection(model, _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarSelectionCell.identifire, for: indexPath) as? CarSelectionCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configure(with: model)
            setPositionSelectedCarColor(cell)
            return cell
            
        case let .level(model, _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GeneralCell.identifire, for: indexPath) as? GeneralCell else {
                return UITableViewCell()
            }
            
            if model.state {
                cell.accessoryType = .checkmark
                levelLastSelectedIndexPath = indexPath
            }
            cell.configure(with: ModelGeneralCell(name: model.levelName, state: model.state))
            return cell
            
        case let .control(model, _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GeneralCell.identifire, for: indexPath) as? GeneralCell else {
                return UITableViewCell()
            }
            
            if model.state {
                cell.accessoryType = .checkmark
                controlLastSelectedIndexPath = indexPath
            }
            cell.configure(with: ModelGeneralCell(name: model.nameControl, state: model.state))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderInSection
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return heightForFooterInSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < model.sections.count else { return nil }
        
        let sectionItem = model.sections[section]
        
        let headerView = SectionHeader(frame: CGRect(x: .zero, y: .zero, width: tableView.frame.width, height: .zero))
        
        headerView.configure(with: ModelHeader(title: sectionItem.title))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.section < model.sections.count,
              indexPath.row < model.sections[indexPath.section].rows.count
        else {
            return 0
        }
        
        return model.sections[indexPath.section].rows[indexPath.row].rowHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard indexPath.section < model.sections.count,
              indexPath.row < model.sections[indexPath.section].rows.count
        else {
            return
        }
        
        let rowItem = model.sections[indexPath.section].rows[indexPath.row]
        
        guard let cell = cell as? CornerRadiusConfigurable else {
            return }
        
        switch rowItem {
            
        case .nameUser(_, .bottom), .carSelection(_, .bottom), .level(_, .bottom), .control(_, .bottom):
            cell.setRoundCorner(state: .bottom, radius: AppDesign.mainCornerRadius)
            
        case .nameUser(_, .auto), .carSelection(_, .auto), .level(_, .auto), .control(_, .auto):
            cell.setRoundCorner(
                state: roundСornersCells(indexPath: indexPath, tableView),
                radius: AppDesign.mainCornerRadius
            )
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? GeneralCell else { return }
        
        cell.accessoryType = .checkmark
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == levelLastSelectedIndexPath || indexPath == controlLastSelectedIndexPath {
            return
        }
        
        let currencyIsSelected = model.sections[indexPath.section].rows[indexPath.row]
        
        presenter.setSelectedCell(currencyIsSelected,
                                  indexPath: indexPath,
                                  levelSelected: levelLastSelectedIndexPath,
                                  controlSelected: controlLastSelectedIndexPath)
    }
}


extension SettingController: SettingViewProtocol {
    
    func success(model: ModelSettingDTO) {
        self.model = model
        settingView.tableView.reloadData()
    }
    
    func updateCell(accessoryType: UITableViewCell.AccessoryType, indexPath: IndexPath, lastSelected: LastSelectedIndex) {
        guard let cellSelected = settingView.tableView.cellForRow(at: indexPath) as? GeneralCell else {
            return
        }
        cellSelected.accessoryType = accessoryType
        
        switch lastSelected {
        case .levelLastSelectedIndexPath(let indexPath):
            levelLastSelectedIndexPath = indexPath
        case .controlLastSelectedIndexPath(let indexPath):
            controlLastSelectedIndexPath = indexPath
        }
    }
    
    func updateMainHeaderView(model: ModelMainHeader?) {
        prepareMainHeaderView(model: model)
    }
}

extension SettingController: CarSelectionColorDelegate {
    
    func updateCarColor(_ color: UIColor) {
        presenter.updateCarColor(color)
    }
}

