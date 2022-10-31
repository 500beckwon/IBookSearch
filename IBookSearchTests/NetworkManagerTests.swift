//
//  NetworkManagerTests.swift
//  IBookSearchTests
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import XCTest
@testable import IBookSearch

class NetworkManagerTests: XCTestCase {
    
    var urlString: String!
    var data: Data!
    
    override func setUpWithError() throws {
        urlString = "https://api.itbook.store/1.0"
        data = JsonLoader.data(fileName: "SearchBooks")
    }
    
    override func tearDownWithError() throws {
        urlString = nil
        data = nil
    }
    
    func test_fetchData_DataSatusCode200() {
        urlString.append("/search/mongdb")
        let mockURLSession = MockURLSession.make(url: urlString,
                                                 data: data,
                                                 statusCode: 200)
     
        let networkManager = NetworkManager(session: mockURLSession)
       
        var result: BookList?
        networkManager.fetchData(for: urlString,
                      dataType: BookList.self) { response in
            if case let .success(searchBooks) = response {
                result = searchBooks
            }
        }
        
        let expectation: BookList? = JsonLoader.load(type: BookList.self, fileName: "SearchBooks")
        XCTAssertEqual(result?.books.count, expectation?.books.count)
        XCTAssertEqual(result?.books.first?.title, expectation?.books.first?.title)
    }
    
    func test_fetchData_DataWrongDataType() {
        let mockURLSession = MockURLSession.make(url: urlString,
                                                 data: data,
                                                 statusCode: 500)
        let networkManager = NetworkManager(session: mockURLSession)
        
        var result: NetworkError?
        networkManager.fetchData(for: urlString,
                      dataType: BookList.self) { response in
            if case let .failure(error) = response {
                result = error as? NetworkError
            }
        }
        
        // then
        let expectation: NetworkError = NetworkError.invaild
        XCTAssertEqual(result, expectation)
    }
    
    func test_fetchData_DataNothingState500() {
        let mockURLSession = MockURLSession.make(url: urlString,
                                                 data: nil,
                                                 statusCode: 500)
        let networkManager = NetworkManager(session: mockURLSession)
        
        var result: Error?
        networkManager.fetchData(for: urlString,
                      dataType: BookList.self) { response in
            if case let .failure(error) = response {
                result = error
            }
        }
        
        XCTAssertNotNil(result)
    }
}
