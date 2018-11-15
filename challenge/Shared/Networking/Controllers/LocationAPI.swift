//
//  LocationAPI.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

class LocationAPI {
    private let router = Manager<LocationEndPoint>()
    
    func geAllLocations( completion: @escaping (ApiResult<Location>) -> Void )  {
        router.get(resourceUrl: .allLocation, params: nil, paramsHead: nil) { (data, error) in
              completion(ApiResult(data,error))
        }
        
    }
    
}

