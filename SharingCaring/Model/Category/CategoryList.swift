//
//  CategoryList.swift
//  SharingCaring
//
//  Created by TriBQ on 9/20/20.
//

import Foundation

class CategoryList: Codable {
    var categories: [Category] = []

    private enum CodingKeys: String, CodingKey {
        case categories
    }

    init(categories: [Category]) {
        self.categories = categories
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decode([Category].self, forKey: .categories)
    }
}
