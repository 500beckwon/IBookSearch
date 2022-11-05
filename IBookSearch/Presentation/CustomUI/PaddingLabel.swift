//
//  PaddingLabel.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/04.
//

import UIKit

final class PaddingLabel: UILabel {
    var topInset: CGFloat = 10.0
    var bottomInset: CGFloat = 5.0
    var leftInset: CGFloat = 16.0
    var rightInset: CGFloat = 8.0
    
    init(topInset: CGFloat = 10,
         bottomInset: CGFloat = 5,
         leftInset: CGFloat = 16,
         rightInset: CGFloat = 8) {
        self.topInset = topInset
        self.bottomInset = bottomInset
        self.leftInset = leftInset
        self.rightInset = rightInset
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset,
                                  left: leftInset,
                                  bottom: bottomInset,
                                  right: rightInset)
        
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width + leftInset + rightInset
        let height = size.height + topInset + bottomInset
        return CGSize(width: width, height: height)
    }
}
