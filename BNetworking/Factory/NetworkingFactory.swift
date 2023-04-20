//
//  NetworkingFactory.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import Foundation

public final class NetworkingFactory {
    
    public static let shared = NetworkingFactory()
    
    private let requestFactory = RequestFactory()
    
    public func makeRestExecutor() -> RestExecutor {
        return RestExecutor(requestFactory: requestFactory)
    }
}
