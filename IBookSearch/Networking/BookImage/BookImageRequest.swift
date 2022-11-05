//
//  BookImageRequest.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/01.
//

import Foundation

final class BookImageRequest {
    static func requestBookImage(isbn: String, completion: @escaping((Result<Data, Error>) -> Void)) {
        NetworkRequest<Data>(apiRequest: BookImageAPI.imageDownload(isbn: isbn))
            .requestImage(completion: completion)
        
        
    }
}
