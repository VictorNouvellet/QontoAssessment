//
//  DetailBuilder.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

final class DetailBuilder {
    
    static let name = "Detail"
    
    static var storyboard: UIStoryboard { return UIStoryboard(name: self.name, bundle: Bundle.main) }
    
    static func getView(user: UserMainViewModel) -> DetailViewController? {
        let view = self.storyboard.instantiateInitialViewController() as? DetailViewController
        let interactor = DetailInteractor()
        interactor.view = view
        interactor.user = user
        view?.interactor = interactor
        return view
    }
}
