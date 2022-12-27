//
//  TransitionImageView.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/05.
//

import UIKit

final class TransitionImageView: UIImageView {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        accessibilityIgnoresInvertColors = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
