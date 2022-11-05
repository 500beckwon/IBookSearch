//
//  SearchLoadingTableCell.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/02.
//

import UIKit

class SearchLoadingTableCell: UITableViewCell {
    private let indicator = UIActivityIndicatorView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        contentView.addSubview(indicator)
        
        indicator.hidesWhenStopped = true
        
        indicator.anchor(centerX: contentView.centerXAnchor,
                         centerY: contentView.centerYAnchor)
    }
    
    func startLoading() {
        indicator.startAnimating()
    }
}
