//
//  MainViewModel.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

struct MainViewModel {
    let userList: [UserMainViewModel]?
    
    static func defaultModel() -> MainViewModel {
        return MainViewModel(userList: nil)
    }
}
