//
//  BookCollectionViewCell.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/05.
//

import UIKit

final class BookCollectionViewCell: BaseCollectionViewCell {
    
    public private(set) var bookInfoLabel  = UILabel()
    private var stackView = UIStackView()
    private var selectedView = UIView()
    private var titleLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
        titleLabel.text = nil
        bookInfoLabel.text = nil
        selectedView.isHidden = true
    }
    
    func configureCell(_ book: Book?) {
        guard let book = book else { return }
        titleLabel.text = book.title
        bookInfoLabel.text = book.subTitle
        bookImageView.setImageUrl(book.isbnNumber)
    }
    
    func setHighlighted(_ isHighlighted: Bool) {
        selectedView.isHidden = !isHighlighted
    }
}

private extension BookCollectionViewCell {
    func setupLayout() {
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    func insertUI() {
        [
            bookImageView,
            stackView,
            selectedView
        ].forEach {
            contentView.addSubview($0)
        }
        
        [
            titleLabel,
            bookInfoLabel
        ].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func basicSetUI() {
        let size = contentView.bounds.size
        
        contentView.backgroundColor = .systemBackground
        
        bookImageView.clipsToBounds = true
        bookImageView.contentMode = .scaleAspectFill
        
        selectedView.backgroundColor = .systemGray.withAlphaComponent(0.3)
        selectedView.isHidden = true
        titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.preferredMaxLayoutWidth = size.width/2 - 40
        titleLabel.textAlignment = .left
        
        bookInfoLabel.preferredMaxLayoutWidth = size.width/2 - 40
        bookInfoLabel.textAlignment = .left
        bookInfoLabel.font = .systemFont(ofSize: 10, weight: .medium)
        bookInfoLabel.numberOfLines = 3
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
    }
    
    func anchorUI() {
        bookImageView
            .anchor(
                leading: contentView.leadingAnchor,
                paddingLeading: 6,
                centerY: contentView.centerYAnchor,
                width: 60,
                height: 70)
        
        selectedView.anchor(
            top: contentView.topAnchor,
            bottom: contentView.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor
        )
        
        stackView.anchor(
            leading: bookImageView.trailingAnchor,
            paddingLeading: 6,
            centerY: bookImageView.centerYAnchor
        )
    }
}
