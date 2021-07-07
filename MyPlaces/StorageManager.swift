//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Artyom on 7.07.21.
//  Copyright © 2021 Artyom Yarmoluk. All rights reserved.

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ place: Place) {
        
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deleteObject(_ place: Place) {
        
        try! realm.write {
            realm.delete(place)
        }
    }
}
