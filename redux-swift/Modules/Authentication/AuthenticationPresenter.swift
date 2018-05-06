//
//  AuthenticationPresenter.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 05.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

protocol AuthenticationPresenterInterface {
    func usernameChanged(to username: String)
    func passwordChanged(to password: String)
    func tappedSignIn()
}

class AuthenticationPresenter: AuthenticationPresenterInterface {
    
    private let store: StateStoreListeningInterface
    private let interactor: AuthenticationInteractorInterface
    private var lastState: AuthenticationState
    
    init(store: StateStoreListeningInterface, interactor: AuthenticationInteractorInterface) {
        self.interactor = interactor
        self.store = store
        lastState = store.state.authentication
        store.subscribe(self)
    }
    
    deinit {
        store.unsubscribe(self)
    }
    
    func usernameChanged(to username: String) {
        interactor.usernameChanged(to: username)
    }
    
    func passwordChanged(to password: String) {
        interactor.passwordChanged(to: password)
    }
    
    func tappedSignIn() {
        interactor.signIn()
    }
}

extension AuthenticationPresenter: StateStoreListener {
    
    func stateChanged(to state: AppState) {
        
    }
}
