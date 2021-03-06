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
        case .production: return "localhost:8888/api"
        case .develop: return "https://fiesta.esncz.org/api/"
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
