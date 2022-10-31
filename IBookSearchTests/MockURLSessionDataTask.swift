//
//  MockURLSessionDataTask.swift
//  IBookSearchTests
//
//  Created by ByungHoon Ann on 2022/10/31.
//

@testable import IBookSearch

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private let resumeHandler: () -> Void
    
    init(resumeHandler: @escaping () -> Void) {
        self.resumeHandler = resumeHandler
    }
    
    func resume() {
        resumeHandler()
    }
}
