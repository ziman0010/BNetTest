//
//  SearchInteractor.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import LINetworking
import UIKit

protocol SearchBuisnessLogic: AnyObject {
    func viewDidLoad()
    func search(query: String)
}

final class SearchInteractor: SearchBuisnessLogic {
    
    private let searchManager: SearchManager
    var presenter: SearchPresentationLogic?
    
    init(searchManager: SearchManager) {
        self.searchManager = searchManager
    }
    
    func viewDidLoad() {
        searchManager.showAll { response in
            guard let response = response else {
                return
            }
            self.presenter?.present(response: response)
        }
    }
    
    func search(query: String) {
        guard !query.isEmpty else {
            presenter?.presentError(type: .emptyQuery)
            return
        }
        
        searchManager.searchPhoto(query: query) { response in
            guard let response = response else {
                self.presenter?.presentError(type: .smthWentWrong)
                return
            }
            if response.isEmpty {
                self.presenter?.presentError(type: .noResults)
            } else {
                self.presenter?.present(response: response)
            }
        }
    }
}
