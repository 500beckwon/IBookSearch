//
//  NSMutableAttributedString.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/06.
//

import UIKit

extension NSMutableAttributedString {
    func bold(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
}
