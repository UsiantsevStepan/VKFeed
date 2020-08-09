//
//  NetworkManager.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 04.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation

protocol Network {
    
    func getData(with endpoint: EndpointProtocol, completion: @escaping ((Result<Data,Error>) -> Void))
    
    func performRequest(for endpoint: EndpointProtocol) -> URLRequest?
    
    func sendRequest(_ request: URLRequest, completion: @escaping ((Result<Data,Error>) -> Void))
    
}

class NetworkManager {
    
    private let session = URLSession(configuration: .default)
    
}

extension NetworkManager: Network {
    
    func getData(with endpoint: EndpointProtocol, completion: @escaping ((Result<Data, Error>) -> Void)) {
        guard let request = performRequest(for: endpoint) else { return }
        
        sendRequest(request, completion: completion)
    }
    
    func performRequest(for endpoint: EndpointProtocol) -> URLRequest? {
        guard var urlComponents = URLComponents(string: endpoint.fullURL) else {
            return nil
        }
        
        urlComponents.queryItems = endpoint.params.compactMap { param -> URLQueryItem in
            return URLQueryItem(name: param.key, value: param.value)
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
    
    func sendRequest(_ request: URLRequest, completion: @escaping ((Result<Data, Error>) -> Void)) {
        let task = session.dataTask(with: request) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            completion(.success(data))
            
        }
        task.resume()
    }
}
