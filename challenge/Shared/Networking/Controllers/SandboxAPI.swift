//
//  LocationAPI.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire

class SandboxAPI {
    let routerSandbox = Manager<SandboxEndPoint>()
    let routerStatus = Manager<StatusEndPoint>()
    
    func getPosts( completion: @escaping (_ locations: Any?,_ error: NetworkError?)->() ){
        routerSandbox.get(resourceUrl: .posts, params: nil, paramsHead: nil) { (data, error) in
            // Todo: Change into model
            
            completion(data, error)
            return
        }
    }
    
    func getStatus(id: Int, completion: @escaping (_ locations: Any?,_ error: NetworkError?)->()) {
        routerStatus.get(resourceUrl: .status(id: id), params: nil, paramsHead: nil) { (data, error) in
            completion(data, error)
            return
        }
    }
    
}

