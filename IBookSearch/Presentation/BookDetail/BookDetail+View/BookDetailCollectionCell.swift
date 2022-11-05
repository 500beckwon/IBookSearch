//
//  BookDetailCollectionCell.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/04.
//

import UIKit

final class BookDetailCollectionCell: BaseCollectionViewCell {
    
    private var scrollView = UIScrollView()
    private var containerView = UIView()
    public private(set) var imageView = UIImageView()
    private var stackView = UIStackView()
    private var titleLabel = PaddingLabel()
    private var subTitleLabel = PaddingLabel()
    private var authorLabel = PaddingLabel()
    private var detailLabel = PaddingLabel()
    private var priceLabel = PaddingLabel()
    private var publisherLabel = PaddingLabel()
    private var pageCountLabel = PaddingLabel()
    private var publisherYearLabel = PaddingLabel()
    private var viewModel: BookDetailViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
        authorLabel.text = nil
        detailLabel.text = nil
        priceLabel.text = nil
        publisherLabel.text = nil
        pageCountLabel.text = nil
        publisherYearLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detailRequestBook(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
        viewModel.requestBookDetail()
        imageView.setImageUrl(viewModel.isbnNumberString)
        viewModel.resultHandler = { [weak self] bookDetail in
            guard let self = self else { return }
            guard let bookDetail = bookDetail else { return }
            DispatchQueue.main.async {
                self.configureBook(detailBook: bookDetail)
            }
        }
    }
    
    private func configureBook(detailBook: DetailBook) {
        titleLabel.text      = detailBook.title
        authorLabel.text     = detailBook.authors
        subTitleLabel.text   = detailBook.subtitle
        
        detailLabel.attributedText = NSMutableAttributedString()
            .bold(string: "소개", fontSize: 15)
            .bold(string: "\n\(detailBook.descripiton)", fontSize: 13)
        
        publisherLabel.attributedText = NSMutableAttributedString()
            .bold(string: "출판사", fontSize: 15)
            .bold(string: "\n\(detailBook.publisher)", fontSize: 13)
        
        pageCountLabel.text  = "\(detailBook.pages)p"
        
        publisherYearLabel.attributedText = NSMutableAttributedString()
            .bold(string: "출간일", fontSize: 15)
            .bold(string: "\n\(detailBook.year)", fontSize: 13)
        
        priceLabel.attributedText = NSMutableAttributedString()
            .bold(string: "가격", fontSize: 15)
            .bold(string: "\n\(detailBook.price)", fontSize: 13)
    }
}

private extension BookDetailCollectionCell {
    func setupLayout() {
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    func insertUI() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(stackView)
        
        
        [
            imageView,
            titleLabel,
            authorLabel,
            subTitleLabel,
            detailLabel,
            publisherLabel,
            pageCountLabel,
            publisherYearLabel,
            priceLabel
        ].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func basicSetUI() {
        contentView.backgroundColor = .systemBackground
        
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        labelBasicSet()
    }
    
    func labelBasicSet() {
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .center
        
        authorLabel.font = .systemFont(ofSize: 16, weight: .bold)
        authorLabel.textAlignment = .center
        authorLabel.numberOfLines = 3
        
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .left
        detailLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        authorLabel.font = .systemFont(ofSize: 14, weight: .bold)
        authorLabel.numberOfLines = 0
        
        publisherLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        publisherLabel.numberOfLines = 0
        
        pageCountLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        pageCountLabel.numberOfLines = 0
        
        publisherYearLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        publisherYearLabel.numberOfLines = 0
        
        priceLabel.numberOfLines = 0
        priceLabel.font = .systemFont(ofSize: 12, weight: .semibold)
    }
    
    func anchorUI() {
        scrollView
            .anchor(top: contentView.topAnchor,
                    bottom: contentView.bottomAnchor,
                    leading: contentView.leadingAnchor,
                    trailing: contentView.trailingAnchor,
                    width: contentView.frame.width)
        
        containerView
            .anchor(top: scrollView.topAnchor,
                    bottom: scrollView.bottomAnchor,
                    leading: scrollView.leadingAnchor,
                    trailing: scrollView.trailingAnchor,
                    width: contentView.frame.width)
        
        stackView
            .anchor(top: containerView.topAnchor,
                    bottom: containerView.bottomAnchor,
                    paddingBottom: 20,
                    leading: containerView.leadingAnchor,
                    trailing: containerView.trailingAnchor)
        
        imageView.anchor(
            width: contentView.frame.width,
            height: contentView.frame.width
        )
    }
}
