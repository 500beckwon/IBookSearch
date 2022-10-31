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
        
        listGuideLabel.font = .boldSystemFont(ofSize: 20)
        listGuideLabel.backgroundColor = .systemBackground
        listGuideLabel.textColor = .systemBlue
        listGuideLabel.textAlignment = .center
        listGuideLabel.text = guideText
    }
    
    func anchorUI() {
        listGuideLabel
            .anchor(centerX: centerXAnchor,
                    centerY: centerYAnchor,
                    centerYConstant: -50)
    }
}

extension BookListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
