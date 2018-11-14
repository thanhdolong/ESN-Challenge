//
//  Router
//  challenge
//
//  Created by Thành Đỗ Long on 13/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func get(resourceUrl: EndPoint, params: [String: Any]?, paramsHead: [String: String]?, completion: @escaping(Any?, NetworkError?) -> Void)
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    let networkCLient = NetworkClient()
    
    func get(resourceUrl: EndPoint, params: [String : Any]?, paramsHead: [String : String]?, completion: @escaping (Any?, NetworkError?) -> Void) {
        let resourceUrl = resourceUrl.baseURL.appendingPathComponent(resourceUrl.path)
        
        networkCLient.requestFor(resourceUrl: resourceUrl, method: .get, parametersBody: nil, parametersHead: paramsHead) { (response) in
            self.responseParser(response: response, completion: completion)
        }
    }
    
    private func responseParser(response: DataResponse<Any>, completion: @escaping(Any?, NetworkError?) -> Void) {
        
        guard let dataResponse = response.response, let result = response.result.value else {
            return completion(nil, NetworkError.serverDown)
        }
        
        if dataResponse.statusCode.isSuccessHTTPCode {
            return completion(result, nil)
        }
        
        let networkError = NetworkError(response: dataResponse)
        return completion(nil, networkError)
    }
}


