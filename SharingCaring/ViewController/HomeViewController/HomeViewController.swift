//
//  HomeViewController.swift
//  SharingCaring
//
//  Created by TriBQ on 9/20/20.
//

import UIKit
import SideMenu
import WebKit

class HomeViewController: BaseViewController {
    private var webView: WKWebView?
    private var selectedCategory: Category?

    override func initView() {
        webView = WKWebView(frame: self.view.frame)
        guard  let webView = webView else {
            return
        }
        self.view.addSubview(webView)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Identifier.sideMenu,
              let destination = segue.destination as? SideMenuNavigationController
        else {
            return
        }
        destination.alwaysAnimate = true
        destination.presentationStyle = .menuSlideIn
        destination.animationOptions = .beginFromCurrentState
        destination.allowPushOfSameClassTwice = false
        destination.dismissOnPresent = false
        destination.dismissOnPush = false
        destination.enableSwipeToDismissGesture = true
        destination.enableTapToDismissGesture = true
        if let sideMenuTableView = destination.viewControllers.first as? SideMenuViewController {
            sideMenuTableView.delegate = self
            sideMenuTableView.setSelectedCategory(category: selectedCategory)
        }
    }

    private func initWeb(url: String) {
        guard let url = URL(string: url) else {
            print("error")
            return
        }
        let request = URLRequest(url: url)
        webView?.load(request)
    }
}

extension HomeViewController: SideMenuDelegate {
    func didTap(category: Category) {
        initWeb(url: category.categoryUrl)
        selectedCategory = category
    }
}
