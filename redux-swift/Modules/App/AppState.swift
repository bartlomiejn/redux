//
//  AppState.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

struct AppState: State {
    var authentication: AuthenticationState
    
    init(authentication: AuthenticationState = AuthenticationState(isLoggedIn: false, username: nil, password: nil)) {
        self.authentication = authentication
    }
}
