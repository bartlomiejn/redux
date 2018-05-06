//
//  AppReducer.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

struct AppState: State {
    var authentication = AuthenticationState(signInState: .notSignedIn, username: nil, password: nil)
}

class AppReducer {
    
    let authenticationReducer: AuthenticationReducer
    
    init(authenticationReducer: AuthenticationReducer) {
        self.authenticationReducer = authenticationReducer
    }
    
    func reduce(action: Action, state: AppState) -> AppState {
        return AppState(authentication: authenticationReducer.reduce(action: action, state: state.authentication))
    }
}
