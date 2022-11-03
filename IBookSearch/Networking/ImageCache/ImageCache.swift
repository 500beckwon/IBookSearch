//
//  File.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()
    
    private var imageCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    
    private init() { }
    
    func cacheClearAll() {
        imageCache.removeAllObjects()
    }
    
    func removeCache(imageName: String) {
        imageCache.removeObject(forKey: NSString(string: imageName))
    }
    
    func imageObject(imageName: String) -> UIImage? {
        if let memoryImage = imageCache.object(forKey: NSString(string: imageName)) {
            return memoryImage
        } else {
            return imageDiskObject(imageName: imageName)
        }
    }
    
    func setCache(imageName: String,
                  image: UIImage) {
        imageCache.setObject(image, forKey: NSString(string: imageName))
    }
    
    func imageDiskObject(imageName: String) -> UIImage? {
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        if let dataPath = cachesDirectory?
            .appendingPathComponent("DiskCache")
            .appendingPathComponent(imageName) {
            guard let imageData = try? Data(contentsOf: dataPath),
                  let image = UIImage(data: imageData) else {
                return nil }
            
            setCache(imageName: imageName, image: image)
            return image
            
        } else {
            return nil
        }
    }
    
    func setDiskCache(imageName: String,
                      imageData: Data) {
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory,
                                                     in: .userDomainMask).first else { return }
        let dataPath = cachesDirectory.appendingPathComponent("DiskCache")
        
        if !fileManager.fileExists(atPath: dataPath.path) {
            do {
                try fileManager.createDirectory(atPath: dataPath.path,
                                                withIntermediateDirectories: false,
                                                attributes: nil)
            } catch {
                print("Disk Cache 저장 실패 = ",error.localizedDescription)
            }
        }
        
        let savePath = dataPath.appendingPathComponent(imageName)
        fileManager.createFile(atPath: savePath.path,
                               contents: imageData,
                               attributes: nil)
    }
}
