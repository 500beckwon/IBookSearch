//
//  BookListViewController.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import UIKit

final class BookListViewController: UIViewController {
    public private(set) var searchBar = BookSearchBar()
    public private(set) var bookListView = BookListView()
    public private(set) var loadingIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

private extension BookListViewController {
    func setupLayout() {
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    func insertUI() {
        [
            searchBar,
            bookListView,
            loadingIndicator
        ].forEach {
            view.addSubview($0)
        }
    }
    
    func basicSetUI() {
        title = "책 목록"
        view.backgroundColor = .systemBackground
        
        loadingIndicator.color = .systemGray
        loadingIndicator.hidesWhenStopped = true
    }
    
    func anchorUI() {
        searchBar
            .anchor(
                top: view.safeAreaLayoutGuide.topAnchor,
                leading: view.leadingAnchor,
                trailing: view.trailingAnchor,
                height: 40
            )
        
        bookListView
            .anchor(
                top: searchBar.bottomAnchor,
                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                leading: view.leadingAnchor,
                trailing: view.trailingAnchor
            )
        
        loadingIndicator
            .anchor(
                centerX: view.centerXAnchor,
                centerY: view.centerYAnchor
            )
    }
}
