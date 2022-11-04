//
//  BookDetailCollectionCell.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/04.
//

import UIKit

final class BookDetailCollectionCell: UICollectionViewCell {
    private var scrollView = UIScrollView()
    private var containerView = UIView()
    private var imageView = UIImageView()
    private var titleLabel = PaddingLabel()
    private var subTitleLabel = PaddingLabel()
    private var authorLabel = PaddingLabel()
    private var detailLabel = PaddingLabel()
    private var priceLabel = PaddingLabel()
    private var stackView = UIStackView()
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
    
    func detailRequest(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
        viewModel.requestBookDetail()
        viewModel.resultHandler = { [weak self] bookDetail in
            guard let self = self else { return }
            guard let bookDetail = bookDetail else { return }
            DispatchQueue.main.async {
                self.configureBook(detailBook: bookDetail)
            }
        }
    }
    
    func configureBook(detailBook: DetailBook) {
        titleLabel.text      = "저서   :  \(detailBook.title)"
        authorLabel.text     = "저자   : \(detailBook.authors)"
        subTitleLabel.text   = """
                               
                               소개
                               \(detailBook.subtitle)
                               """
        detailLabel.text     =
                               """
                               
                               상세
                               \(detailBook.descripiton)
                               """
        publisherLabel.text  = "출판사 : \(detailBook.publisher)"
        pageCountLabel.text  = "장수   : \(detailBook.pages)p"
        publisherYearLabel.text = "출간일  : \(detailBook.year)년"
        priceLabel.text      = "가격  : \(detailBook.price)"
        imageView.setImageUrl(detailBook.isbnLongNumber)
    }
}

private extension BookDetailCollectionCell {
    private func setupLayout() {
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    private func insertUI() {
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
    
    private func basicSetUI() {
        contentView.backgroundColor = .systemBackground
        
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        labelBasicSet()
    }
    
    private func labelBasicSet() {
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        authorLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        detailLabel.numberOfLines = 0
        detailLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        authorLabel.font = .systemFont(ofSize: 14, weight: .bold)
        publisherLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        pageCountLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        publisherYearLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        priceLabel.font = .systemFont(ofSize: 12, weight: .semibold)
    }
    
    private func anchorUI() {
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
