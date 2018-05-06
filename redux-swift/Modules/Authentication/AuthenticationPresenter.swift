//
//  AuthenticationPresenter.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 05.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

class AuthenticationPresenter {
    
    private let store: StateStore
    private let actionCreator: AuthenticationActionCreatorInterface
    
    init(store: StateStore, actionCreator: AuthenticationActionCreatorInterface) {
        self.store = store
        self.actionCreator = actionCreator
        store.subscribe(withObserver: self)
    }
    
    deinit {
        store.unsubscribe(observer: self)
    }
    
    func usernameChanged(to username: String) {
        store.dispatch(UpdateSignInUsername(username: username))
    }
    
    func passwordChanged(to password: String) {
        store.dispatch(UpdateSignInPassword(password: password))
    }
    
    func tappedSignIn() {
        store.dispatchAsync(actionCreator.signIn)
    }
}

extension AuthenticationPresenter: StateStoreObserver {
    
    func stateChanged(to state: AppState) {
        
    }
}
