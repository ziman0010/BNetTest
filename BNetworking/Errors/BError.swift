//
//  BError.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import Foundation

enum LIError: String, Error {
    case cannotConvertedIntoModel = "Response cannot be converted into model type"
    case cannotLoadImage = "Image cannot be loaded"
    
}
