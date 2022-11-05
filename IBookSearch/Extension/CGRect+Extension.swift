//
//  CGRect+Extension.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/05.
//

import UIKit

extension CGRect {
    static func makeRect(aspectRatio: CGSize, insideRect rect: CGRect) -> CGRect {
        
        let viewRatio = rect.width / rect.height
        let imageRatio = aspectRatio.width / aspectRatio.height
        let touchesHorizontalSides = (imageRatio > viewRatio)
        let result: CGRect
        if touchesHorizontalSides {
            let height = rect.width / imageRatio
            let height2 = rect.height / imageRatio
            //let yPoint = rect.minY + (rect.height - height) / 2
            let yPoint = height2 - rect.height
            result = CGRect(x: 0, y: yPoint, width: rect.width, height: height)
        } else {
            let width = rect.height * imageRatio
            let xPoint = rect.minX + (rect.width - width) / 2
            result = CGRect(x: xPoint, y: 0, width: width, height: rect.height)
        }
        return result
    }
}
