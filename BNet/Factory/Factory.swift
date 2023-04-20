//
//  Factory.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import Foundation
import LINetworking

final class Factory {
    
    static let shared = Factory()
    
    func createSearchManager() -> SearchManager {
        let restExecuter =  NetworkingFactory.shared.makeRestExecutor()
        return SearchManager(restExecuter: restExecuter)
    }
    
    func createImageLoader() -> ImageLoader {
        let restExecuter =  NetworkingFactory.shared.makeRestExecutor()
        return ImageLoader(restExecuter: restExecuter)
    }
}
