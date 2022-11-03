//
//  BookTableViewCell.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import UIKit

final class BookTableViewCell: UITableViewCell {
    public private(set) var bookImageView  = UIImageView()
    public private(set) var bookTitleLabel = UILabel()
    public private(set) var bookInfoLabel  = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
        bookTitleLabel.text = nil
        bookInfoLabel.text = nil
    }
    
    func configureCell(_ book: Book?) {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        bookInfoLabel.text = book.subTitle
        bookImageView.setImageUrl(book.isbnNumber)
    }
}

private extension BookTableViewCell {
    func setupLayout() {
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    func insertUI() {
        [
            bookImageView,
            bookTitleLabel,
            bookInfoLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    func basicSetUI() {
        contentView.backgroundColor = .systemBackground
        
        bookImageView.layer.cornerRadius = 5
        bookImageView.clipsToBounds = true
        bookImageView.contentMode = .scaleAspectFill
        
        bookTitleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        bookTitleLabel.numberOfLines = 2
        
        bookInfoLabel.font = .systemFont(ofSize: 10, weight: .medium)
        bookInfoLabel.numberOfLines = 3
    }
    
    func anchorUI() {
        bookImageView
            .anchor(leading: contentView.leadingAnchor,
                    paddingLeading: 16,
                    centerY: contentView.centerYAnchor,
                    width: 80,
                    height: 60)
        
        bookTitleLabel
            .anchor(top: contentView.topAnchor,
                    paddingTop: 30,
                    leading: bookImageView.trailingAnchor,
                    paddingLeading: 15,
                    trailing: bookInfoLabel.trailingAnchor,
                    paddingTrailing: 16)
        
        bookInfoLabel
            .anchor(top: bookTitleLabel.bottomAnchor,
                    paddingTop: 5,
                    leading: bookImageView.trailingAnchor,
                    paddingLeading: 15,
                    trailing: contentView.trailingAnchor,
                    paddingTrailing: 16)
    }
}
