//
//  ImageResultResponse.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import Foundation

public struct ItemResponse: Codable {
    
    public let id: Int
    public let image: String
    public let description: String
    public let name: String
}

extension Array: RequestResponse {}
