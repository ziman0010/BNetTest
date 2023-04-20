//
//  SearchPresenter.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import Foundation
import LINetworking

protocol SearchPresentationLogic: AnyObject {
    func present(response: [ItemResponse])
    func presentError(type: SearchError)
}

final class SearchPresenter: SearchPresentationLogic {
    
    weak var viewController: SearchDisplayLogic?
    
    func present(response: [ItemResponse]) {
        let items = response.map {
            Item(image: $0.image, description: $0.description, name: $0.name)
        }
        viewController?.set(viewObject: items)
//        if let imageResults = imageResults {
//            viewController?.set(viewObject: imageResults)
//        } else {
//            viewController?.clear()
//            viewController?.showError(title: "Warning", message: SearchError.noResults.rawValue)
//        }
    }
    
    func presentError(type: SearchError) {
        viewController?.showError(title: "Warning", message: type.rawValue)
    }
}

