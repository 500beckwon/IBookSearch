//
//  Book.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import Foundation

struct Book: Codable {
    let title: String
    let subTitle: String
    let isbnNumber: String
    let price: String
    let image: String
    let storeUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case subTitle = "subtitle"
        case isbnNumber = "isbn13"
        case price
        case image
        case storeUrl = "url"
    }
}
