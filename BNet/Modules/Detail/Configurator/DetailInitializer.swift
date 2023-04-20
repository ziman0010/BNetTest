//
//  DetailInitializer.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//


import UIKit

final class DetailInitializer: NSObject {
    
    @IBOutlet private weak var viewController: DetailViewController!
    
    static func controller(item: Item) -> DetailViewController {
        
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! DetailViewController
        
        let configurator = DetailConfigurator()
        configurator.configure(viewController: viewController,
                               item: item)
        
        return viewController
    }
}
