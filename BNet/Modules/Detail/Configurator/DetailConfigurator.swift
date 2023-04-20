//
//  DetailConfigurator.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import Foundation

final class DetailConfigurator {
    
    func configure(viewController: DetailViewController,
                   item: Item) {
        
        let factory = Factory.shared
        let presenter = DetailPresenter()
        presenter.viewController = viewController
        
        let interactor = DetailInteractor(imageLoader: factory.createImageLoader(),
                                          item: item)
        interactor.presenter = presenter
        
        viewController.interactor = interactor
    }
}
