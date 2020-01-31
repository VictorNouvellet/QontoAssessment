//
//  UserDefaultsConfig.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

struct UserDefaultsConfig {
    @UserDefault("cached_users", defaultValue: [RandomUser]())
    static var cachedUsers: [RandomUser]
}
