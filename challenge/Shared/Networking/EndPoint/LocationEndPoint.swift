//
//  locationEndPoint.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

public enum LocationEndPoint {
    case allLocation
    case location(id:Int)
}

extension LocationEndPoint: EndPointType {
    fileprivate var environmentBaseURL : String {
        switch NetworkClient.environment {
        case .production: return "https://jsonplaceholder.typicode.com/"
        case .develop: return "http://192.168.77.49:8888/api/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    
    var path: String {
        switch self {
        case .location(let id):
            return "location/\(id)"
        case .allLocation:
            return "location"
        }
    }
}
