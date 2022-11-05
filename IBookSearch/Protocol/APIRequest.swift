//
//  APIRequest.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import Foundation

protocol APIRequest {
    var urlString: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String : String]? { get }
    var headers: [String: String]? { get }
    var httpBody: Data? { get }
}

extension APIRequest {
    var urlString: String {
        return "https://api.itbook.store/1.0"
    }

    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : String]? {
        return nil
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var httpBody: Data? {
        return nil
    }
}



