//
//  BookListViewModel.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/01.
//

import Foundation

enum BookListStyle {
    case new
    case search
}

class BookListViewModel {
    private var page = 0
    private var isLoading = false
    private var hasNextPage = true
    private var searchText = ""
    private var bookList = [Book]()
    
    var isHasNextPage: Bool {
        return hasNextPage
    }
    
    var listCount: Int {
        return bookList.count
    }
    
    var bookListInfo: [Book] {
        return bookList
    }
    
    var searchInfo: SearchInformation {
        return SearchInformation(page: page, searchText: searchText)
    }
    
    var resultHandler: (() -> Void)?
    
    func recodeSearchTest(text: String) {
        searchText = text
    }
    
    func numberOfRowInSection() -> Int {
        return searchText.isEmpty ? 1:2
    }
    
    func numberOfRowInCell(section: Int) -> Int {
        if section == 0 {
            return bookList.count
        } else {
            return hasNextPage ? 1:0
        }
    }
    
    func getBook(index: Int) -> Book {
        return bookList[index]
    }
    
    func requestSearchReset() {
        hasNextPage = true
        isLoading = true
        page = 0
        searchText = ""
        requestNewBookList()
    }
    
    func searchingRequest(isPaging: Bool = true) {
        guard hasNextPage,
              !isLoading,
              !searchText.isEmpty else { return }
        
        if !isPaging {
            page = 0
        }
        
        requestSearchBookList { [weak self] bookList in
            guard let self = self else { return }
            self.isLoading = false
            self.hasNextPage = !bookList.books.isEmpty
            if self.page == 0 {
                self.bookList = bookList.books
            } else {
                self.bookList.append(contentsOf: bookList.books)
            }
            self.page += 1
            self.resultHandler?()
        }
    }
    
    func requestNewBookList() {
        BookListRequest
            .requestNewBooks { [weak self] result in
                self?.isLoading = false
                switch result {
                case .success(let bookList):
                    self?.bookList = bookList.books
                    self?.resultHandler?()
                case .failure:
                    self?.bookList = []
                    self?.resultHandler?()
                }
            }
    }
    
    func requestSearchBookList(completion: @escaping(BookList) -> Void) {
        BookListRequest
            .requestSearchBook(searchInfo: searchInfo) { result in
                switch result {
                case .success(let success):
                    completion(success)
                case .failure:
                    completion(BookList(total: "", page: "", books: []))
                }
            }
    }
}


