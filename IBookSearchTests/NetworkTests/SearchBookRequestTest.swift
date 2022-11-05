//
//  SearchBookRequestTest.swift
//  IBookSearchTests
//
//  Created by ByungHoon Ann on 2022/11/03.
//

import XCTest
@testable import IBookSearch

class SearchBookRequestTest: XCTestCase {
    var data: Data!
    override func setUpWithError() throws {
        data = JsonLoader.data(fileName: "SearchBooks")
    }
    
    override func tearDownWithError() throws {
        data = nil
    }
    
    func testRequestSuccessSearchBookList() throws {
        let apiRequest = BookListAPI.searchBook(searchInfo: SearchInformation(page: 0, searchText: "mongodb"))
        
        let mockNetworkSession = MockURLSession.make(url: apiRequest.urlString,
                                                     data: data,
                                                     statusCode: 200)
        
        let newBookListFetch: NetworkRequest<BookList> = NetworkRequest(apiRequest: apiRequest,
                                                                        session: mockNetworkSession)
        var newBookList: BookList?
        newBookListFetch.requestFetch { result in
            newBookList = try? result.get()
        }
        
        let expectation: BookList? = JsonLoader.load(type: BookList.self, fileName: "SearchBooks")
        XCTAssertEqual(newBookList?.books.count, expectation?.books.count)
        XCTAssertEqual(newBookList?.books.first?.title, expectation?.books.first?.title)
    }
    
    func testRequestFailureNewBookList() throws {
        let apiRequest = BookListAPI.newBooks
        let mockNetworkSession = MockURLSession.make(url: apiRequest.urlString,
                                                     data: nil,
                                                     statusCode: 500)
        let newBookListFetch: NetworkRequest<BookList> = NetworkRequest(apiRequest: apiRequest,
                                                                        session: mockNetworkSession)
        var newBookListRequestError: NetworkError?
        newBookListFetch.requestFetch { result in
            if case .failure(let error) = result {
                newBookListRequestError = error as? NetworkError
            }
        }
        
        let inValidError = NetworkError.inValidError
        XCTAssertEqual(newBookListRequestError, inValidError)
    }
}
