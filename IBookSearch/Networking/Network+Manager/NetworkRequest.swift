//
//  NetworkRequest.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/01.
//

import Foundation

final class NetworkRequest<T: Codable> {
    
    private let apiRequest: APIRequest
    
    let session: URLSessionProtocol
    
    init(apiRequest: APIRequest, session: URLSessionProtocol = URLSession.shared) {
        self.apiRequest = apiRequest
        self.session = session
    }
    
    public func makeURL(_ apiRequest: APIRequest) -> URL? {
        var urlComponents = URLComponents(string: apiRequest.urlString)
        if let parameters = apiRequest.parameters {
            let query = parameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
            urlComponents?.queryItems = query
        }
        
        urlComponents?.path.append(apiRequest.path)
        return urlComponents?.url
    }
    
    public func requestFetch(completion: @escaping((Result<T, Error>) -> Void)) {
        guard let url = makeURL(apiRequest) else {
            completion(.failure(NetworkError.badURL))
            return }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data,
               let response = response as? HTTPURLResponse,
               200..<300 ~= response.statusCode {
                do {
                    print(data, url)
                    let data = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            } else {
                completion(.failure(NetworkError.inValidError))
            }
        }
        dataTask.resume()
    }
    
    public func requestImage(completion: @escaping((Result<Data,Error>) -> Void)) {
        guard let url = makeURL(apiRequest) else {
            completion(.failure(NetworkError.badURL))
            return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data,
               let response = response as? HTTPURLResponse,
               200..<300 ~= response.statusCode {
                do {
                    completion(.success(data))
                }
            } else {
                completion(.failure(NetworkError.inValidError))
            }
        }
        dataTask.resume()
    }
}
