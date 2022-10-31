//
//  NetworkManager.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import UIKit

final class NetworkManager {
    var bsseURL: URL {
        guard let url = URL(string: "https://api.itbook.store/1.0") else {
            fatalError("\(URLError.badURL)")
        }
        return url
    }
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared)  {
        self.session = session
    }
    
    func fetchData<T: Decodable>(for url: String,
                                 dataType: T.Type,
                                 completion: @escaping((Result<T, Error>) -> Void)) {
        
        guard let url = URL(string: url) else { return }

        let dataTask = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            if let data = data,
               let response = response as? HTTPURLResponse,
               200..<400 ~= response.statusCode {
                
                do {
                    let data = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            } else {
                completion(.failure(NetworkError.invaild))
            }
        }
        
        dataTask.resume()
    }
    
    func requestImage(urlString: String, completion: @escaping((Result<Data, Error>) -> Void)) {
        if let url = URL(string: urlString) {
            session.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let imageData = data, error == nil
                else {
                    completion(.failure(NetworkError.decodingError))
                    return
                }
                completion(.success(imageData))
            }.resume()
        } else {
            completion(.failure(NetworkError.badURL))
        }
    }
}

