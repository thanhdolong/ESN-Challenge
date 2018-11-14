//
//  StatusEndPoint.swift
//  challenge
//
//  Created by Thành Đỗ Long on 13/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import Foundation

public enum StatusEndPoint {
    case status(id:Int)
}

extension StatusEndPoint: EndPointType {
    fileprivate var environmentBaseURL : String {
        switch NetworkClient.environment {
        case .production: return "https://httpstat.us/"
        case .develop: return "https://httpstat.us/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    
    var path: String {
        switch self {
        case .status(let id):
            return "\(id)"
        }
    }
}
