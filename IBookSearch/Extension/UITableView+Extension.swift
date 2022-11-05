//
//  UITableView+Extension.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cell: T.Type) {
        register(cell.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier,
                                           for: indexPath) as? T else {
            fatalError("Unable to dequeue Reusable UITableViewCell")
        }
        return cell
    }
}
