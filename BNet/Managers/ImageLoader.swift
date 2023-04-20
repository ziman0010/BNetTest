//
//  ImageLoader.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import UIKit
import LINetworking

final class ImageLoader {
    
    private let restExecuter: RestExecutor
    
    init(restExecuter: RestExecutor) {
        self.restExecuter = restExecuter
    }
    
    func load(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if
            let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)),
            let image = UIImage(data: cachedResponse.data)
        {
            completion(image)
        } else {
            restExecuter.loadImage(url: url) { result in
                switch result {
                case .success(let response):
                    let data = response.0
                    if let httpUrlResponse = response.1 {
                        let cachedResponse = CachedURLResponse(response: httpUrlResponse, data: data)
                        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
                    }
                    if let image = UIImage(data: data) {
                        completion(image)
                    } else {
                        completion(nil)
                    }
                case .failure(_):
                    completion(nil)
                }
            }
        }
    }
    
    func loadFromHost(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard
            let fullUrlString = ("http://shans.d2.i-partner.ru" + urlString).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let fullUrl = URL(string: fullUrlString)
        else {
            completion(nil)
            return
        }
        if
            let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: fullUrl)),
            let image = UIImage(data: cachedResponse.data)
        {
            completion(image)
        } else {
            restExecuter.loadImage(url: fullUrl) { result in
                switch result {
                case .success(let response):
                    let data = response.0
                    if let httpUrlResponse = response.1 {
                        let cachedResponse = CachedURLResponse(response: httpUrlResponse, data: data)
                        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: fullUrl))
                    }
                    if let image = UIImage(data: data) {
                        completion(image)
                    } else {
                        completion(nil)
                    }
                case .failure(_):
                    completion(nil)
                }
            }
        }
    }
}
