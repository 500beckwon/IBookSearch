//
//  BookDetailRequestTest.swift
//  IBookSearchTests
//
//  Created by ByungHoon Ann on 2022/11/04.
//

import XCTest
@testable import IBookSearch

class BookDetailRequestTest: XCTestCase {
    var data: Data!
    var isbn: String!
    
    override func setUpWithError() throws {
        isbn = "9781617294136"
        data = JsonLoader.data(fileName: "DetailBook")
    }
    
    override func tearDownWithError() throws {
        isbn = nil
        data = nil
    }
    
    func testRequestSuccessDetailBook() throws {
        let apiRequest = BookListAPI.detailBook(isbn: isbn)
        
        let mockNetworkSession = MockURLSession.make(url: apiRequest.urlString,
                                                     data: data,
                                                     statusCode: 200)
        
        let bookDetailFetch: NetworkRequest<Book> = NetworkRequest(apiRequest: apiRequest,
                                                                        session: mockNetworkSession)
        var bookDetail: Book?
        bookDetailFetch.requestFetch { result in
            bookDetail = try? result.get()
        }
        
        let expectation: Book? = JsonLoader.load(type: Book.self, fileName: "DetailBook")
        XCTAssertEqual(bookDetail?.title, expectation?.title)
        XCTAssertEqual(bookDetail?.title, expectation?.title)
    }
    
    func testRequestFailureDetailBook() throws {
        let apiRequest = BookListAPI.detailBook(isbn: isbn)
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
