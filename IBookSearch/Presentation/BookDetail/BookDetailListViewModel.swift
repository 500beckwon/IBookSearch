//
//  BookDetailListViewModel.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/04.
//

import Foundation

final class BookDetailListViewModel {
    
    let bookList: [Book]
    var selectedIndex: Int
    var resultHandler: ((Int) -> Void)?
    
    func numberOfRowInSection() -> Int {
        return 1
    }
    
    func numberOfRowInCell(section: Int) -> Int {
        return bookList.count
    }
    
    var bookTitle: String {
        return bookList[selectedIndex].title
    }
    
    func cellItem(index: Int) -> BookDetailViewModel {
        return BookDetailViewModel(book: bookList[index])
    }
    
    init(bookList: [Book], selectedIndex: Int) {
        print(selectedIndex)
        self.bookList = bookList
        self.selectedIndex = selectedIndex
    }
}
