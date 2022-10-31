//
//  UIImageView+Extension.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import UIKit

extension UIImageView {
    func setImageUrl(_ imageName: String) {
        if let image = ImageCache.shared.imageObject(imageName: imageName) {
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        } else {
            let imageURLString = "https://itbook.store/img/books/\(imageName).png"
            NetworkManager()
                .requestImage(urlString: imageURLString) { result in
                    switch result {
                    case let .success(imageData):
                        
                        ImageCache
                            .shared
                            .setDiskCache(imageName: imageName,
                                          imageData: imageData)
                        
                        DispatchQueue
                            .main
                            .async { [weak self] in
                                self?.image = UIImage(data: imageData)
                            }
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                }
        }
    }
}
