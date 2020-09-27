//
//  UIViewController+Extension.swift
//  SharingCaring
//
//  Created by TriBQ on 9/20/20.
//

import Foundation
import UIKit

extension UIViewController {
    class func instantiate<T: UIViewController>(_: T.Type, storyboard: String) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.className) as? T else {
            fatalError("Can not instantiate viewcontroller from storyboard \(storyboard)")
        }
        return viewController
    }

    static func instantiateFromStoryboard(identifier: String = "") -> Self {
        return instantiateFromStoryboard(viewControllerClass: self, identifier: identifier)
    }

    private static func instantiateFromStoryboard<T: UIViewController>(viewControllerClass: T.Type,
                                                                       identifier: String = "",
                                                                       function: String = #function,
                                                                       line: Int = #line,
                                                                       file: String = #file) -> T {
        var storyboardName = ""
        var controllerIdentifer = ""
        if identifier != "" {
            storyboardName = identifier
            controllerIdentifer = (viewControllerClass as UIViewController.Type).className
        } else {
            storyboardName = (viewControllerClass as UIViewController.Type).className
            controllerIdentifer = storyboardName
        }

        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let scene = storyboard.instantiateViewController(withIdentifier: controllerIdentifer) as? T else {
            fatalError("ViewController with identifier \(storyboardName), not found in \(storyboardName) Storyboard.\nFile : \(file) \nLine Number : \(line)")
        }
        return scene
    }
}
