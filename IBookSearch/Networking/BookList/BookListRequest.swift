//
//  BookListRequest.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/01.
//

import Foundation

final class BookListRequest {
    static func requestNewBooks(completion: @escaping((Result<BookList, Error>) -> Void)) {
        NetworkRequest(apiRequest: BookListAPI.newBooks)
            .requestFetch(completion: completion)
    }
    
    static func requestSearchBook(searchInfo: SearchInformation,
                                  completion: @escaping((Result<BookList, Error>) -> Void)) {
        NetworkRequest(apiRequest: BookListAPI.searchBook(searchInfo: searchInfo))
            .requestFetch(completion: completion)
    }
    
    static func requestDetailBook(isbn: String,
                                  completion: @escaping((Result<Book, Error>) -> Void)) {
        NetworkRequest(apiRequest: BookListAPI.detailBook(isbn: isbn))
            .requestFetch(completion: completion)
    }
}
