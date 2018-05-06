//
//  LoggerMiddleware.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

class LoggerMiddleware: Middleware {
    func process(action: Action, store: StateStore) {
        print("LoggerMiddleware\n    \(action)\n    For state: \(store.state)")
    }
}
