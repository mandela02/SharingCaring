//
//  BaseViewController.swift
//  SharingCaring
//
//  Created by TriBQ on 9/20/20.
//

import Foundation
import UIKit
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initObservers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissView()
    }

    func initView() {}

    func refreshView() {}

    func dismissView() {}

    func initObservers() {}
}
