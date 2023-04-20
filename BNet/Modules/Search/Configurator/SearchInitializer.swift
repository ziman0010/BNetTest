//
//  SearchInitializer.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import UIKit

final class SearchInitializer: NSObject {
    
    @IBOutlet private weak var viewController: SearchViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let configurator = SearchConfigurator()
        configurator.configure(viewController: viewController)
    }
}
