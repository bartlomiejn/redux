//
//  AppReducer.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

/**
 Application state tree.
 */
struct AppState: State {
    var authentication = AuthenticationState(signInState: .notSignedIn, username: nil, password: nil)
}

/**
 Generates next application state based on provided action.
 */
struct Reducer {
    let authenticationReducer: AuthenticationReducer
    
    init(authenticationReducer: AuthenticationReducer) {
        self.authenticationReducer = authenticationReducer
    }
    
    func reduce(action: Action, state: AppState) -> AppState {
        return AppState(authentication: authenticationReducer.reduce(action: action, state: state.authentication))
    }
}
