//
//  AuthenticationReducer.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

func authenticationReducer(action: Action, state: AuthenticationState?) -> AuthenticationState {
    switch action {
    case let _ as LoginUsernameUpdated:
        break
    case let _ as LoginPasswordUpdated:
        break
    default:
        break
    }
    return AuthenticationState(isLoggedIn: false, username: nil, password: nil)
}
