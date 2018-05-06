//
//  Middleware.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

protocol Middleware: class {
    /**
     Logic to be executed before performing state reduction.
     */
    func process(action: Action, store: StateStore)
}
