//
//  RequestFactory.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import Foundation

final class RequestFactory {
    
    func createSearchGetRequest(query: String) -> Request {
        
        let params = ["search" : query]
        
        let request = Request(method: .get, host: "http://shans.d2.i-partner.ru", path: "/api/ppp/index/", headers: [:], params: params)
        
        return request
    }
    
    func createIndexGetRequest() -> Request {
        let request = Request(method: .get, host: "http://shans.d2.i-partner.ru", path: "/api/ppp/index/", headers: [:], params: [:])
        
        return request
    }
    
}
