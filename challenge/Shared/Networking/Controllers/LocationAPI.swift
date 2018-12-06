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
    private let locationRouter = Manager<LocationEndPoint>()
    private let authRouter = Manager<AuthEndPoint>()
    
    func geAllLocations( completion: @escaping (ApiResult<Location>) -> Void )  {
        let paramsHead = ["hash": LocalDatabase.databaseHash ?? ""]
        
        locationRouter.get(resourceUrl: .allLocation, params: nil, paramsHead: paramsHead) { (data, header, error) in
            completion(ApiResult(data, header, error))
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Any?, NetworkError?) -> Void ) {
        let params = [
            "email": email,
            "password": password
        ]
        
        authRouter.post(resourceUrl: .login, params: params, paramsHead: nil) { (data, header, error) in
            guard let data = data, header?.statusCode.isSuccessHTTPCode == true else {
                return completion(nil, error)
            }
            
            completion(data, nil)
        }
    }
    
    func geAllLocationsAsObjects( completion: @escaping (ApiResult<LocationObject>) -> Void )  {
        locationRouter.get(resourceUrl: .allLocation, params: nil, paramsHead: ["hash": LocalDatabase.databaseHash ?? ""]) { (data, header, error) in
            completion(ApiResult(data, header, error))
        }
    }
    
}

