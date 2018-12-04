//
//  AuthEndPoint.swift
//  challenge
//
//  Created by Thành Đỗ Long on 03/12/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

import Foundation

public enum AuthEndPoint {
    case login
}

extension AuthEndPoint: EndPointType {
    fileprivate var environmentBaseURL : String {
        switch NetworkClient.environment {
        case .production: return "https://httpstat.us/"
        case .develop: return "http://192.168.77.47:8888/api/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    
    var path: String {
        switch self {
        case .login:
            return "auth"
        }
    }
}
