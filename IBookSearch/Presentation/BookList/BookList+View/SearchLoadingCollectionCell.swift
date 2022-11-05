//
//  SearchLoadingCollectionCell.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/05.
//

import UIKit

final class SearchLoadingCollectionCell: UICollectionViewCell {
    private let indicator = UIActivityIndicatorView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.addSubview(indicator)
        
        indicator.hidesWhenStopped = true
        
        indicator.anchor(centerX: contentView.centerXAnchor,
                         centerY: contentView.centerYAnchor)
    }
    
    func startLoading() {
        indicator.startAnimating()
    }
}
