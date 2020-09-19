//
//  Categories.swift
//  SharingCaring
//
//  Created by TriBQ on 9/20/20.
//

import Foundation

class Category: Codable {
    var chid: String
    var name: String
    var slug: String
    var total: Int
    var shortName: String
    var categoryUrl: String
    var cover: String

    enum CodingKeys: String, CodingKey {
        case chid = "CHID"
        case name
        case slug
        case total = "total_videos"
        case shortName = "shortname"
        case categoryUrl = "category_url"
        case cover = "cover_url"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chid = try values.decode(String.self, forKey: .chid)
        name = try values.decode(String.self, forKey: .name)
        slug = try values.decode(String.self, forKey: .slug)
        total = try values.decode(Int.self, forKey: .total)
        shortName = try values.decode(String.self, forKey: .shortName)
        categoryUrl = try values.decode(String.self, forKey: .categoryUrl)
        cover = try values.decode(String.self, forKey: .cover)
    }
}
