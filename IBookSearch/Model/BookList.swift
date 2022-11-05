//
//  BookList.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import Foundation

struct BookList: Codable {
    let total: String
    let page: String?
    let books: [Book]
}
