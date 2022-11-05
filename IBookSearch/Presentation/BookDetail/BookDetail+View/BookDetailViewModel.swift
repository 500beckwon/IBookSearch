//
//  BookDetailViewModel.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/04.
//

import Foundation

final class BookDetailViewModel {
    let book: Book
    
    var isbnNumberString: String {
        return book.isbnNumber
    }
    
    var resultHandler: ((DetailBook?) -> Void)?
    
    init(book: Book) {
        self.book = book
    }
    
    func requestBookDetail() {
        BookListRequest
            .requestDetailBook(isbn: isbnNumberString) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let detailBook):
                    self.resultHandler?(detailBook)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.resultHandler?(nil)
                }
        }
    }
}
