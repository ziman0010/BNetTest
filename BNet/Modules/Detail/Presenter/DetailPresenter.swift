//
//  DetailPresenter.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import UIKit

protocol DetailPresentationLogic: AnyObject {
    func present(image: UIImage?, name: String, description: String)
}

final class DetailPresenter: DetailPresentationLogic {
    
    weak var viewController: DetailDisplayLogic?
    
    //MARK: - DetailPresenter
    
    func present(image: UIImage?, name: String, description: String) {
        viewController?.set(image: image, name: name, description: description)
    }
}

