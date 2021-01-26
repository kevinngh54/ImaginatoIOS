//
//  RealmHelper.swift
//  TestLogin
//
//  Created by NHK on 1/26/21.
//  Copyright © 2021 NHK. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    var realm: Realm?
    static let shared = RealmHelper()
    init() {
        realm = try! Realm()
    }
    
    func save(completion: (Realm) -> Void) {
        guard let realm = realm else { return }
        realm.beginWrite()
        completion(realm)
        do {
            try realm.commitWrite()
        } catch {
            realm.cancelWrite()
        }
    }
    
    func add(object: Object) {
        save { realm in
            realm.add(object)
        }
    }
}
