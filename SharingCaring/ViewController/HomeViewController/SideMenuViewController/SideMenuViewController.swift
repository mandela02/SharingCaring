//
//  SideMenuViewController.swift
//  SharingCaring
//
//  Created by TriBQ on 9/21/20.
//

import UIKit
import RxSwift

protocol SideMenuDelegate: class {
    func didTap(category: Category)
}

class SideMenuViewController: BaseViewController {
    private let viewModel = SideMenuViewModel()
    @IBOutlet weak var sideMenuTableView: UITableView!

    weak var delegate: SideMenuDelegate?

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        initTableView()
    }

    override func initObservers() {
        viewModel.categories.subscribe(onNext: {[weak self] _ in
            self?.sideMenuTableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.tableStatus.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.sideMenuTableView.reloadSections(IndexSet([0]), with: .fade)
            UIView.performWithoutAnimation {
                self.sideMenuTableView.reloadData()
            }
            if self.viewModel.isExpanded {
                self.initSelectedCell()
            }
        }).disposed(by: disposeBag)
    }

    private func register() {
        sideMenuTableView.register(UINib(nibName: SideMenuTableViewCell.className,
                                         bundle: nil),
                                   forCellReuseIdentifier: SideMenuTableViewCell.className)
        sideMenuTableView.register(UINib(nibName: SideMenuHeaderView.className,
                                         bundle: nil),
                                   forHeaderFooterViewReuseIdentifier: SideMenuHeaderView.className)
    }

    private func initTableView() {
        sideMenuTableView.dataSource = self
        sideMenuTableView.delegate = self
    }

    private func initSelectedCell() {
        if let indexPath = viewModel.getSelectedIndexPath() {
            sideMenuTableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
        }
    }

    func setSelectedCategory(category: Category?) {
        viewModel.selectedCategory.accept(category)
    }
}

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isExpanded ? viewModel.categories.value.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: SideMenuTableViewCell.className, for: indexPath)
                as? SideMenuTableViewCell else {
            return UITableViewCell()
        }
        cell.createCell(category: viewModel.categories.value[indexPath.row])
        return cell
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView
                .dequeueReusableHeaderFooterView(withIdentifier: SideMenuHeaderView.className)
                as? SideMenuHeaderView else {
            return UIView()
        }
        header.createHeader(isExpanded: viewModel.isExpanded)
        header.delegate = self
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = viewModel.categories.value[indexPath.row]
        viewModel.selectedCategory.accept(viewModel.categories.value[indexPath.row])
        delegate?.didTap(category: category)
    }
}

extension SideMenuViewController: HeaderDelegate {
    func didTapHeader() {
        viewModel.switchTableStatus()
    }
}
