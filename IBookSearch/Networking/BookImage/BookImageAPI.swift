//
//  BookImageAPI.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/01.
//

import Foundation

enum BookImageAPI {
    case imageDownload(isbn: String)
}

extension BookImageAPI: APIRequest {
    var urlString: String {
        return "https://itbook.store/img/books"
    }
    
    var baseURL: URL {
        guard
            let url = URL(string: "https://itbook.store/img/books")
        else {
            fatalError("\(URLError.badURL)")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .imageDownload(let isbn):
            return "/\(isbn).png"
        }
    }
}

