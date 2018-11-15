//
//  Manager.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func get(resourceUrl: EndPoint, params: [String: Any]?, paramsHead: [String: String]?, completion: @escaping(Any?, NetworkError?) -> Void)
}

class Manager<EndPoint: EndPointType>: NetworkRouter {
    
    private let networkCLient = NetworkClient()
    
    func get(resourceUrl: EndPoint, params: [String : Any]?, paramsHead: [String : String]?, completion: @escaping (Any?, NetworkError?) -> Void) {
        let resourceUrl = resourceUrl.baseURL.appendingPathComponent(resourceUrl.path)
        
        networkCLient.requestFor(resourceUrl: resourceUrl, method: .get, parametersBody: nil, parametersHead: paramsHead) { (response, status) in
            switch status {
            case .success:
                self.responseParser(response: response, completion: completion)
            case .failure:
                completion(nil, NetworkError(response: response.response))
            }
        }
    }
    
    
    private func responseParser(response: DataResponse<Any>, completion: @escaping(Any?, NetworkError?) -> Void) {
        
        guard let result = response.result.value else {
            return completion(nil, NetworkError.unsuccessError("Cannot return the result of responze serialization"))
        }
        
        
        return completion(result, nil)
    }
}


