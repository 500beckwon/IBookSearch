//
//  CGFloat+Extension.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/05.
//

import UIKit

extension CGFloat {
    static func scaleAndShift(value: CGFloat,
                              inRange: (min: CGFloat,
                                        max: CGFloat),
                              toRange: (min: CGFloat, max: CGFloat) = (min: 0.0, max: 1.0)) -> CGFloat {
        if value < inRange.min {
            return toRange.min
        } else if value > inRange.max {
            return toRange.max
        } else {
            let ratio = (value - inRange.min) / (inRange.max - inRange.min)
            return toRange.min + ratio * (toRange.max - toRange.min)
        }
    }
}
