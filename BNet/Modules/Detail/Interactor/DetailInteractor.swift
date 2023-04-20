//
//  DetailInteractor.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import UIKit

protocol DetailBuisnessLogic: AnyObject {
    
    func viewDidLoad()
}

final class DetailInteractor: DetailBuisnessLogic {
    
    private let imageLoader: ImageLoader
    
    
    private let item: Item
    
    var presenter: DetailPresentationLogic?
    
    init(imageLoader: ImageLoader,
         item: Item) {
        
        self.imageLoader = imageLoader
        self.item = item
    }
    
    //MARK: - DetailBuisnessLogic
    
    func viewDidLoad() {
        let urlString = item.image
        let name = item.name
        let description = item.description
        
        imageLoader.loadFromHost(urlString: urlString) { [weak self] image in
            self?.presenter?.present(image: image, name: name, description: description)
        }
        
    }
}
