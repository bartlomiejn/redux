//
//  AuthenticationState.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

struct AuthenticationState: State {
    var isLoggedIn: Bool
    var username: String?
    var password: String?
}
