//
//  UserDefault.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        set {
            let encoder = JSONEncoder()
            UserDefaults.standard.set(try? encoder.encode(newValue), forKey: key)
        }
        get {
            guard let cachedUsersData = UserDefaults.standard.object(forKey: key) as? Data else { return defaultValue }
            let decoder = JSONDecoder()
            return (try? decoder.decode(T.self, from: cachedUsersData)) ?? defaultValue
        }
    }
}
