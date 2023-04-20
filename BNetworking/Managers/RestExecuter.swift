//
//  RestExecuter.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import Foundation
import Alamofire

public final class RestExecutor {
    
    private let requestFactory: RequestFactory
    
    init(requestFactory: RequestFactory) {
        
        self.requestFactory = requestFactory
    }
    
    public func performAllItems(completion: @escaping ((Result<RequestResponse, Error>) -> Void)) {
        
        let request = requestFactory.createIndexGetRequest()
        fetch(request) { response in
            switch response {
            case .success(let response):
                guard let response = response as? [ItemResponse] else {
                    completion(.failure(LIError.cannotConvertedIntoModel))
                    return
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func performSearchGet(query: String, completion: @escaping ((Result<RequestResponse, Error>) -> Void)) {
        
        let request = requestFactory.createSearchGetRequest(query: query)
        fetch(request) { response in
            switch response {
            case .success(let response):
                guard let response = response as? [ItemResponse] else {
                    completion(.failure(LIError.cannotConvertedIntoModel))
                    return
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func loadImage(url: URL, completion: @escaping (Result<(Data, HTTPURLResponse?), Error>) -> Void) {
        
        AF.request(url, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success((data, response.response)))
            case .failure(_):
                completion(.failure(LIError.cannotLoadImage))
            }
        }
    }
    
    private func fetch(_ request: Request, _ completion: @escaping ((Result<RequestResponse, Error>) -> Void)) {
        let requestURL = request.requestURL
        let method = request.method
        let headers = HTTPHeaders(request.headers)
        let params = request.params
        
        AF.request(requestURL, method: method, parameters: params, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode([ItemResponse].self, from: data)
                        completion(.success(response))
                    } catch (let error) {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
