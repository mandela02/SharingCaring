//
//  CategoriesResponse.swift
//  SharingCaring
//
//  Created by TriBQ on 9/20/20.
//

import Foundation

class CategoriesResponse: Codable {
    var isSuccess: Bool
    var response: CategoryList

    private enum CodingKeys: String, CodingKey {
        case isSuccess = "success"
        case response
    }

    init(isSuccess: Bool = false) {
        self.isSuccess = isSuccess
        self.response = CategoryList(categories: [])
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isSuccess = try values.decode(Bool.self, forKey: .isSuccess)
        response = try values.decode(CategoryList.self, forKey: .response)
    }
}
