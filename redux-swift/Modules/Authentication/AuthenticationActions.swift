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
    func signIn(store: StateStore, state: AppState, callback: (Action?) -> Void)
}

class AuthenticationActionCreator: AuthenticationActionCreatorInterface {
    
    func signIn(store: StateStore, state: AppState, callback: (Action?) -> Void) {
        callback(nil)
    }
}
