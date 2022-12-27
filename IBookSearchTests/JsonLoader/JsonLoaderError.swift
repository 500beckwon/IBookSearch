//
//  JsonLoaderError.swift
//  IBookSearchTests
//
//  Created by ByungHoon Ann on 2022/11/03.
//

import Foundation

enum JsonLoaderError: Error {
    case unknownFile
    case dataConvertFail
    case notJsonData
    case decodeFail
}
