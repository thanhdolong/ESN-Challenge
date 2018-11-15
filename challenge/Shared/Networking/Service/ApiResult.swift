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
    let data: Any?
    let error: NetworkError?
    
    init(_ data: Any?,_ error: NetworkError?) {
        self.data = data
        self.error = error
    }
    
    func unwrap() throws -> [T] {
        guard let data = data as? [[String: AnyObject]] else {
            if let error = error {
                throw error
            }
            throw NetworkError.badRequest
        }
        
        do {
            let model: [T] = try unbox(dictionaries: data)
            dump(model)
            return model
        } catch (let error){
            print("An error occurred: \(error)")
            throw error
        }
    }
}
