//
//  AuthenticationState.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

enum SignInState {
    case notSignedIn
    case signingIn
    case success
    case failure
}

struct AuthenticationState: State {
    var signInState: SignInState
    var username: String?
    var password: String?
}
