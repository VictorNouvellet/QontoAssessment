//
//  MainInteractor.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation

protocol MainInteractorInterface {
    var callbackModelUpdate: (_ model: MainViewModel) -> () { get set }
    func onViewDidAppear()
    func onViewDidLoad()
}

final class MainInteractor {
    // MARK: - Injected vars
    
    weak var view: MainViewController!
    
    // MARK: - Private vars
    
    private var model = MainViewModel.defaultModel() { didSet { self.onModelUpdate(model) } }
    
    // MARK: - Internal vars
    
    var callbackModelUpdate: (_ model: MainViewModel) -> () = { _ in }
}

// MARK: - Internal methods

extension MainInteractor: MainInteractorInterface {
    func onViewDidAppear() {
        // Update things on view did appear
    }
    
    func onViewDidLoad() {
        // Everything starts here
    }
}

// MARK: - Private methods

private extension MainInteractor {
    
    // MARK: Model handler
    /// Should not be used directly
    func onModelUpdate(_ newModel: MainViewModel) {
        callbackModelUpdate(newModel)
    }
}

