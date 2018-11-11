//
//  databaseManager.swift
//  challenge
//
//  Created by Thành Đỗ Long on 08/11/2018.
//  Copyright © 2018 Thành Đỗ Long. All rights reserved.
//

import UIKit
import RealmSwift

enum DatabaseError: Error {
    case databaseLoadingError
    case loadingRecipesError
    case loadingDataError
    case saveDataError
    case deleteDataError
}

final class Database {
    static let context = Database()
    
    private let realm: Realm
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
    
    func insertObjects(_ objects: [Object], update: Bool) throws {
        do {
            try realm.write {
                realm.add(objects, update: update)
            }
        } catch (let error) {
            print(error)
            throw DatabaseError.saveDataError
        }
    }
    
    func createOrUpdate<Model, RealmObject: Object>(model: Model, with reverseTransformer: (Model) -> RealmObject) {
        let object = reverseTransformer(model)
        try! realm.write {
            realm.add(object, update: true)
        }
    }
    
    func fetch<Model, RealmObject>(with request: FetchRequest<Model, RealmObject>) -> Model {
        var results = realm.objects(RealmObject.self)
        
        if let predicate = request.predicate {
            results = results.filter(predicate)
        }
        
        if request.sortDescriptors.count > 0 {
            results = results.sorted(by: request.sortDescriptors)
        }
        
        return request.transformer(results)
    }
    
    func fetch<Model, RealmObject: Object>(with predicate: NSPredicate?, sortDescriptors: [SortDescriptor], transformer: (Results<RealmObject>) -> Model) -> Model {
        var results = realm.objects(RealmObject.self)
        
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        
        if sortDescriptors.count > 0 {
            results = results.sorted(by: sortDescriptors)
        }
        
        return transformer(results)
    }
    
    func delete<RealmObject: Object>(type: RealmObject.Type, with primaryKey: String) {
        let object = realm.object(ofType: type, forPrimaryKey: primaryKey)
        if let object = object {
            try! realm.write {
                realm.delete(object)
            }
        }
    }
    
    func deleteAllFromDatabase() throws {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch (let error) {
            print(error)
            throw DatabaseError.deleteDataError
        }
    }
}
