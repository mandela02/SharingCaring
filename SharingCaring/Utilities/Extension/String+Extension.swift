//
//  String+Extension.swift
//  SharingCaring
//
//  Created by TriBQ on 9/28/20.
//

import Foundation

extension String {
    var javCategory: String {
        let strings = self.components(separatedBy: "・")
        return strings.first ?? ""
    }
}
