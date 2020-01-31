//
//  UserListMainViewModel.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

struct UserListMainViewModel {
    let id: String
    let firstname: String
    let lastname: String
    let email: String
}

extension UserListMainViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
