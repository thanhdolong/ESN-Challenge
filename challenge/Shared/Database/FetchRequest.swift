//
//  FetchRequest.swift
//  DataPersistence
//
//  Created by ShengHua Wu on 17/04/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import RealmSwift

struct FetchRequest<Model, RealmObject: Object> {
    let predicate: NSPredicate?
    let sortDescriptors: [SortDescriptor]
    let transformer: (Results<RealmObject>) -> Model
}

extension SortDescriptor {
    static let name = SortDescriptor(keyPath: "name", ascending: true)
}

extension Location {
    static let all = FetchRequest<[Location], LocationObject>(predicate: nil, sortDescriptors: [SortDescriptor.name]) { (LocationObjectsResult) -> [Location] in
        let result = LocationObjectsResult.map({ (locationObject) -> Location in
            return Location(location: locationObject)
        })
        
        return Array(result)
    }
}
