//
//  UserDefaultsBacked.swift
//  GithubReposMVVM
//
//  Created by kotl on 22.12.2020.
//

import Foundation

/// Use this wrapper for variables you want to get/set value from/to `UserDefaults`
@propertyWrapper struct UserDefaultsBacked<Value> {

    let key: String
    let defaultValue: Value
    var storage: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            let value = storage.value(forKey: key) as? Value
            return value ?? defaultValue
        }
        set {
            storage.setValue(newValue, forKey: key)
        }
    }

}
