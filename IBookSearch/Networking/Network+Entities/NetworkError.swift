//
//  NetworkError.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

enum NetworkError: Error {
    case emptyData
    case decodingError
    case badURL
    case inValidError
}
