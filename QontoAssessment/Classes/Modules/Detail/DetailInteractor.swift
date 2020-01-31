//
//  DetailInteractor.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

protocol DetailInteractorInterface {
    var callbackModelUpdate: (_ model: DetailViewModel) -> () { get set }
    func onViewDidLoad()
}

final class DetailInteractor {
    // MARK: - Injected vars
    
    weak var view: DetailViewController!
    var user: UserMainViewModel!
    
    // MARK: - Private vars
    
    private var model = DetailViewModel.defaultModel() { didSet { self.onModelUpdate(model) } }
    
    // MARK: - Internal vars
    
    var callbackModelUpdate: (_ model: DetailViewModel) -> () = { _ in }
}

// MARK: - Internal methods

extension DetailInteractor: DetailInteractorInterface {
    func onViewDidLoad() {
        self.model = DetailViewModel(user: user)
    }
}

// MARK: - Private methods

private extension DetailInteractor {
    
    // MARK: Model handler
    /// Should not be used directly
    func onModelUpdate(_ newModel: DetailViewModel) {
        callbackModelUpdate(newModel)
    }
}

