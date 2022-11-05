//
//  BookListView.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import Foundation
import UIKit

final class BookListView: UITableView {
    public private(set) var listGuideLabel = UILabel()
    
    private let guideText = "검색결과가 존재하지 않습니다."
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showEmptyLabel(isShow: Bool = true) {
        listGuideLabel.isHidden = false
    }
    
    private func setupLayout() {
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    func insertUI() {
        addSubview(listGuideLabel)
    }
    
    func basicSetUI() {
        backgroundColor = .systemBackground
        tableFooterView = UIView()
        
        registerCell(BookTableViewCell.self)
        registerCell(SearchLoadingTableCell.self)
        
        listGuideLabel.font = .boldSystemFont(ofSize: 20)
        listGuideLabel.backgroundColor = .systemBackground
        listGuideLabel.textColor = .systemBlue
        listGuideLabel.textAlignment = .center
        listGuideLabel.text = guideText
        listGuideLabel.isHidden = true
    }
    
    func anchorUI() {
        listGuideLabel
            .anchor(centerX: centerXAnchor,
                    centerY: centerYAnchor,
                    centerYConstant: -50)
    }
}

