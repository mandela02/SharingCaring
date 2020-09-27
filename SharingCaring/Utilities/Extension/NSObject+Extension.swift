//
//  NSObject+Extension.swift
//  SharingCaring
//
//  Created by TriBQ on 9/20/20.
//

import Foundation

extension NSObject {
    @nonobjc class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    var className: String {
        return type(of: self).className
    }
}
