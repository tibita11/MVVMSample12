//
//  SettingViewController.swift
//  MVVMSample12
//
//  Created by 鈴木楓香 on 2023/02/15.
//

import UIKit
import RxSwift
import RxDataSources

class SettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SettingSectionModel>(configureCell: configureCell)
    
    private lazy var configureCell:
    RxTableViewSectionedReloadDataSource<SettingSectionModel>.ConfigureCell = {
        [weak self] (dataSource, tableView, indexPath, _) in
        let item = dataSource[indexPath]
        switch item {
        case .account, .security, .notification, .contents, .sounds, .dataUsing, .accessibility, .credits, .version, .privacyPolicy:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            var config = cell.defaultContentConfiguration()
            config.text = item.title
            cell.contentConfiguration = config
            cell.accessoryType = item.accessoryType
            return cell
        case .description(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            var config = cell.defaultContentConfiguration()
            config.text = text
            cell.contentConfiguration = config
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    private var viewModel: SettingsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupTableView()
        setupViewModel()
    }
    
    private func setupViewController() {
        navigationItem.title = "設定"
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset.bottom = 12.0
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let item = self?.dataSource[indexPath] else { return }
                self?.tableView.deselectRow(at: indexPath, animated: true)
                switch item {
                case .account:
                    // 遷移させる処理
                    break
                case .security:
                    // 遷移させる処理
                    break
                case .notification:
                    break
                case .contents:
                    break
                case .sounds:
                    break
                case .dataUsing:
                    break
                case .accessibility:
                    break
                case .description:
                    break
                case .credits:
                    break
                case .version:
                    break
                case .privacyPolicy:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupViewModel() {
        viewModel = SettingsViewModel()
        
        viewModel.itemsObservable
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.setup()
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath]
        return item.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.footerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}
