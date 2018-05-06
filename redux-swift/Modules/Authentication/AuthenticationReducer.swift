//
//  AuthenticationReducer.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

class AuthenticationReducer {
    
    func reduce(action: Action, state: AuthenticationState) -> AuthenticationState {
        switch action {
            case let action as UpdateSignInUsername:
                return AuthenticationState(
                    signInState: state.signInState,
                    username: action.username,
                    password: state.password)
            case let action as UpdateSignInPassword:
                return AuthenticationState(
                    signInState: state.signInState,
                    username: state.username,
                    password: action.password)
            case is SigningIn:
                return AuthenticationState(
                    signInState: .signingIn,
                    username: state.username,
                    password: state.password)
            case is SignedIn:
                return AuthenticationState(
                    signInState: .success,
                    username: state.username,
                    password: state.password)
            case is FailedSigningIn:
                return AuthenticationState(
                    signInState: .failure,
                    username: state.username,
                    password: state.password)
            default:
                return state
        }
    }
}
