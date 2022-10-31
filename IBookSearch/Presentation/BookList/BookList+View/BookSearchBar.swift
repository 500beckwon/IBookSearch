//
//  BookSearchBar.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import UIKit

final class BookSearchBar: UISearchBar {
    public private(set) var searchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BookSearchBar {
    func setupLayout() {
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    func insertUI() {
        addSubview(searchButton)
    }
    
    func basicSetUI() {
        backgroundColor = .systemBackground
        searchTextField.autocapitalizationType = .none
        
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    func anchorUI() {
        searchButton
            .anchor(trailing: trailingAnchor,
                    paddingTrailing: 16,
                    centerY: centerYAnchor)
    }
}
