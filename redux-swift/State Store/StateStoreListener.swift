//
//  StateStoreListener.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 06.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

protocol StateStoreListener: class {
    func stateChanged(to state: AppState)
}
