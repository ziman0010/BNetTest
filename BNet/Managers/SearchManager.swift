//
//  SearchManager.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import UIKit
import LINetworking

final class SearchManager {
    
    private let restExecuter: RestExecutor
    
    init(restExecuter: RestExecutor) {
        self.restExecuter = restExecuter
    }
    
    func showAll(completion: @escaping ([ItemResponse]?) -> Void) {
        restExecuter.performAllItems { result in
            switch result {
            case .success(let response):
                guard let response = response as? [ItemResponse] else {
                    completion(nil)
                    return
                }
                completion(response)
            case .failure(let error):
                print("🥲 \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func searchPhoto(query: String, completion: @escaping ([ItemResponse]?) -> Void) {
        restExecuter.performSearchGet(query: query) { result in
            switch result {
            case .success(let response):
                guard let response = response as? [ItemResponse] else {
                    completion(nil)
                    return
                }
                completion(response)
            case .failure(let error):
                print("🥲 \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
