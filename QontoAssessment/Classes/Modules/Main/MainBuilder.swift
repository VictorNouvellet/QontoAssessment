//
//  MainBuilder.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

final class MainBuilder {
    
    static let name = "Main"
    
    static var storyboard: UIStoryboard { return UIStoryboard(name: self.name, bundle: Bundle.main) }
    
    static func getView() -> MainViewController? {
        let view = self.storyboard.instantiateInitialViewController() as? MainViewController
        let interactor = MainInteractor()
        interactor.view = view
        interactor.apiClient = RandomAPIClient()
        view?.interactor = interactor
        return view
    }
}
