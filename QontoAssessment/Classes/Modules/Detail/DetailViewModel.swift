//
//  DetailViewModel.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

struct DetailViewModel {
    let user: UserMainViewModel?
    
    static func defaultModel() -> DetailViewModel {
        return DetailViewModel(user: nil)
    }
}
