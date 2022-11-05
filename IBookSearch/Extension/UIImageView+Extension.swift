//
//  UIImageView+Extension.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import UIKit

extension UIImageView {
    func setImageUrl(_ imageName: String) {
        ImageDownLoader.shared.setImage(to: self, isbn: imageName)
    }
}
