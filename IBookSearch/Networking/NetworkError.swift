//
//  NetworkError.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import Foundation

enum NetworkError: Error {
    case emptyData
    case decodingError
    case badURL
    case invaild
}
