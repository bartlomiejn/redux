//
//  AppReducer.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(authentication: authenticationReducer(action: action, state: state?.authentication))
}
