//
//  BookListAPI.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/01.
//

import Foundation

enum BookListAPI {
    case newBooks
    case searchBook(searchInfo: SearchInformation)
    case detailBook(isbn: String)
}

extension BookListAPI: APIRequest {
    var path: String {
        switch self {
        case .newBooks:
            return "/new"
        case .searchBook(let searchInfo):
            return "/search/\(searchInfo.searchText)/\(searchInfo.page)"
        case .detailBook(let isbn):
            return "/books/\(isbn)"
        }
    }
}
