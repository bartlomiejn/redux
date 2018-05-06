//
//  AuthenticationActions.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

struct UpdateSignInUsername: Action {
    let username: String?
}
struct UpdateSignInPassword: Action {
    let password: String?
}
struct SigningIn: Action {}
struct SignedIn: Action {}
struct FailedSigningIn: Action {}

protocol AuthenticationActionCreatorInterface {
    func signIn(store: StateStore, state: AppState, callback: @escaping (Action?) -> Void)
}

class AuthenticationActionCreator: AuthenticationActionCreatorInterface {
    
    private let service: AuthenticationServiceInterface
    
    init(service: AuthenticationServiceInterface) {
        self.service = service
    }
    
    func signIn(store: StateStore, state: AppState, callback: @escaping (Action?) -> Void) {
        guard let username = state.authentication.username, let password = state.authentication.password else {
            callback(nil)
            return
        }
        service.signIn(username: username, password: password, successCallback: {
            callback(SignedIn())
        }, failureCallback: { error in
            callback(FailedSigningIn())
        })
        
    }
}
