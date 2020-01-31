//
//  UserListMainViewModel.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

struct UserMainViewModel {
    let id: String
    let firstname: String
    let lastname: String
    let email: String
}

extension UserMainViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
