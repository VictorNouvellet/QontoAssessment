//
//  RandomUser.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

struct RandomUser: Codable {
    let login: RandomUserLogin
    let name: RandomUserName
    let email: String
}

struct RandomUserName: Codable {
    let first: String
    let last: String
}

struct RandomUserLogin: Codable {
    let uuid: String
}
