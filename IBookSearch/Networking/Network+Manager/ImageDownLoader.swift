//
//  ImageDownLoader.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/02.
//

import UIKit

final class ImageDownLoader {
    static let shared = ImageDownLoader()
    
    func setImage(to imageView: UIImageView, isbn: String) {
        if let cachedImage = ImageCache.shared.imageObject(imageName: isbn) {
            imageView.image = cachedImage
            return
        }
        
        BookImageRequest
            .requestBookImage(isbn: isbn) { result in
                switch result {
                case .success(let imageData):
                    DispatchQueue.main.async {
                        if let image = UIImage(data: imageData) {
                            ImageCache
                                .shared
                                .setDiskCache(imageName: isbn,
                                              imageData: imageData)
                            imageView.image = image
                        }
                    }
                case .failure(let failure):
                    print("image Download Failure = \(failure.localizedDescription)")
                }
            }
    }
}
