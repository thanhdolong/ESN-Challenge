//
//  ApiResult.swift
//  challenge
//
//  Created by Do Long Thanh on 13/11/2018.
//  Copyright © 2016 ShengHua Wu. All rights reserved.
//

import Foundation
import Unbox

import Foundation

class ApiResult<T: Unboxable> {
    private let result: Any?
    private let error: NetworkError?
    
    init(_ result: Any?,_ error: NetworkError?) {
        self.result = result
        self.error = error
    }
    
    func unwrap() throws -> [T] {
        guard let result = result as? [[String: AnyObject]] else {
            if let error = error { throw error }
            
            throw NetworkError.unsuccessError("[DataError] An error occured while trying unwrap responze")
        }
        
        do {
            let unboxedJSON: [T] = try unbox(dictionaries: result)
            return unboxedJSON
        } catch (let error){
            throw error
        }
    }
}
