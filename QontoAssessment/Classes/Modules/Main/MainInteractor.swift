//
//  MainInteractor.swift
//  QontoAssessment
//
//  Created by Victor Nouvellet on 31/01/2020.
//  Copyright © 2020 Victor Nouvellet. All rights reserved.
//

import Foundation
import Combine

enum MainInteractorError: Error {
    case unexpectedError
}

protocol MainInteractorInterface {
    var callbackModelUpdate: (_ model: MainViewModel) -> () { get set }
    func onViewDidAppear(completion: (() -> Void)?)
    func onViewDidLoad()
    func onTransfersListManualRefresh(completion: (() -> Void)?)
}

final class MainInteractor {
    
    // MARK: Injected vars
    
    weak var view: MainViewController!
    var apiClient: RandomAPIClient!
    
    // MARK: Private vars
    
    private var model = MainViewModel.defaultModel() { didSet { self.onModelUpdate(model) } }
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Internal vars
    
    var callbackModelUpdate: (_ model: MainViewModel) -> () = { _ in }
}

// MARK: - Internal methods

extension MainInteractor: MainInteractorInterface {
    
    func onViewDidLoad() {
        self.model = MainViewModel.defaultModel()
    }
    
    func onViewDidAppear(completion: (() -> Void)?) {
        self.updateUserList(completion: completion)
    }
    
    func onTransfersListManualRefresh(completion: (() -> Void)?) {
        self.updateUserList(completion: completion)
    }
}

// MARK: - Private methods

private extension MainInteractor {
    
    func getUserList(forPage page: UInt = 0, completion: @escaping (Result<[RandomUser], Error>) -> Void) {
        self.apiClient.fetchUserList(forPage: page)
            .replaceError(with: UserDefaultsConfig.cachedUsers)
            .sink(receiveValue: { userList in
                    completion(.success(userList))
                }
            )
            .store(in: &subscriptions)
    }
    
    
    func updateUserList(completion: (() -> Void)? = nil) {
        self.getUserList { result in
            DispatchQueue.main.async(execute: { [weak self] in
                completion?()
                guard case let .success(usersModels) = result else {
                    self?.model = MainViewModel.defaultModel()
                    return
                }
                let userList = usersModels.compactMap { user -> UserListMainViewModel? in
                    return UserListMainViewModel(
                        id: user.login.uuid,
                        firstname: user.name.first,
                        lastname: user.name.last,
                        email: user.email
                    )
                }
                
                // We could also use NSCache instead of UserDefaults
                UserDefaultsConfig.cachedUsers = usersModels
                self?.model = MainViewModel(userList: userList)
            })
        }
    }
    
    // MARK: Model handler
    /// Should not be used directly
    func onModelUpdate(_ newModel: MainViewModel) {
        callbackModelUpdate(newModel)
    }
}

