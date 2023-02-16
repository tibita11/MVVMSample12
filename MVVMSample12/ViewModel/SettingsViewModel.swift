//
//  SettingsViewModel.swift
//  MVVMSample12
//
//  Created by 鈴木楓香 on 2023/02/15.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class SettingsViewModel {
    
    private let items = BehaviorRelay<[SettingSectionModel]>(value: [])
    
    var itemsObservable: Observable<[SettingSectionModel]> {
        return items.asObservable()
    }
    
    func setup() {
        updateItems()
    }
    
    private func updateItems() {
        let sections: [SettingSectionModel] = [
            accountSection(),
            commonSection(),
            oterhSection()
        ]
        items.accept(sections)
    }
    
    private func accountSection() -> SettingSectionModel {
        let items: [SettingsItem] = [
            .account,
            .security,
            .notification,
            .contents
        ]
        return SettingSectionModel(model: .account, items: items)
    }
    
    private func commonSection() -> SettingSectionModel {
        let items: [SettingsItem] = [
            .sounds,
            .dataUsing,
            .dataUsing,
            .accessibility,
            .description(text: "基本設定はこの端末でログインしている全てのアカウントに適用されます。")
        ]
        return SettingSectionModel(model: .common, items: items)
    }
    
    private func oterhSection() -> SettingSectionModel {
        let items: [SettingsItem] = [
            .credits,
            .version,
            .privacyPolicy
        ]
        return SettingSectionModel(model: .other, items: items)
        
    }
    
    
    
    
    
    
}
