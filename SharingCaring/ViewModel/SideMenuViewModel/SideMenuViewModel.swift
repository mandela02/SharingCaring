//
//  SideMenuViewModel.swift
//  SharingCaring
//
//  Created by TriBQ on 9/21/20.
//

import RxSwift
import RxCocoa

enum TableStatus {
    case expanded
    case minimum
}

class SideMenuViewModel {
    let categories: BehaviorRelay<[Category]> = BehaviorRelay(value: [])
    let tableStatus: BehaviorRelay<TableStatus> = BehaviorRelay(value: .minimum)
    let selectedCategory: BehaviorRelay<Category?> = BehaviorRelay(value: nil)
    
    var isExpanded: Bool {
        tableStatus.value == .expanded
    }
    private let disposeBag = DisposeBag()

    init() {
        initData()
    }

    private func initData() {
        Session.shared.getCategoryData().bind(to: categories).disposed(by: disposeBag)
    }

    func switchTableStatus() {
        tableStatus.accept( tableStatus.value == .expanded ? .minimum : .expanded)
    }

    func getSelectedIndexPath() -> IndexPath? {
        guard let category = selectedCategory.value,
              let index = categories.value.firstIndex(where: {$0.chid == category.chid}) else {
            return nil
        }
        return IndexPath(row: index, section: 0)
    }
}
