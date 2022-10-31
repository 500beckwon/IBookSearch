//
//  JsonLoader.swift
//  IBookSearchTests
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import Foundation

private enum JsonLoaderError: Error {
    case unknownFile
    case dataConvertFail
    case notJsonData
    case decodeFail
}

final class JsonLoader {
    static func load<T: Decodable>(type: T.Type, fileName: String) -> T? {
        do {
            let fileURL = try fileURL(of: fileName)
            let data = try fileData(of: fileURL)
            try checkIsJsonData(of: data)
            let decodeData = try decode(of: data, to: type)
            return decodeData
        } catch {
            loggingError(of: error)
            return nil
        }
    }
    
    static func data(fileName: String) -> Data? {
        do {
            let fileURL = try fileURL(of: fileName)
            let data = try fileData(of: fileURL)
            return data
        } catch {
            loggingError(of: error)
            return nil
        }
    }
    
    private static func fileURL(of fileName: String) throws -> URL {
        let testBundle = Bundle.main
        
        let filePath = testBundle.path(forResource: fileName, ofType: "json")
        guard let filePath = filePath else {
            throw JsonLoaderError.unknownFile
        }
        let fileURL = URL(fileURLWithPath: filePath)
        return fileURL
    }
    
    private static func fileData(of fileURL: URL) throws -> Data {
        guard let data = try? Data(contentsOf: fileURL) else {
            throw JsonLoaderError.dataConvertFail
        }
        return data
    }
    
    private static func checkIsJsonData(of data: Data) throws {
        guard let _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            throw JsonLoaderError.notJsonData
        }
    }
    
    private static func decode<T: Decodable>(of data: Data, to type: T.Type) throws -> T {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw JsonLoaderError.decodeFail
        }
        return decodedData
    }
    
    private static func loggingError(of error: Error) {
        switch error {
        case JsonLoaderError.unknownFile:
            print("경로에 file 이 존재하지 x")
        case JsonLoaderError.dataConvertFail:
            print("file data 변환 불가")
        case JsonLoaderError.notJsonData:
            print("file data 가 json 형식이 x. 불필요한 문구 확인 필요")
        case JsonLoaderError.decodeFail:
            print("json 디코딩이 실패. type 획인 필요")
        default:
            print("기타 에러 \(error.localizedDescription)")
        }
    }
}
