//
//  LocationAPI.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire

class LocationAPI {
    let router = Router<LocationEndPoint>()
    
    func geAllLocations( completion: @escaping (_ locations: Any?,_ error: NetworkError?)->() ){
        router.get(resourceUrl: .allLocation, params: nil, paramsHead: nil) { (data, error) in
            
            completion(data, error)
            return
        }
    }
    
}

