//
//  StateStore.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

protocol Action {}

protocol State {}

protocol StateStoreListener: class {
    func stateChanged(to state: AppState)
}

protocol StateBearer: class {
    var state: AppState { get }
}

protocol StateStoreDispatchInterface: StateBearer {
    func dispatch(_ action: Action?)
}

protocol StateStoreListeningInterface: StateBearer {
    func subscribe(_ listener: StateStoreListener)
    func unsubscribe(_ listener: StateStoreListener)
}

class StateStore: StateStoreDispatchInterface, StateStoreListeningInterface {
    
    typealias ReducerFunctionType = (Action, AppState?) -> AppState
    
    private let reducer: AppReducer
    private let queue = DispatchQueue(label: "State Store Dispatch Queue")
    private (set) var state = AppState()
    private var listeners = [StateStoreListener]()
    
    init(reducer: AppReducer) {
        self.reducer = reducer
    }
    
    func subscribe(_ listener: StateStoreListener) {
        listeners.append(listener)
    }
    
    func unsubscribe(_ listener: StateStoreListener) {
        guard let index = listeners.index(where: { $0 === listener }) else {
            return
        }
        listeners.remove(at: index)
    }
    
    func dispatch(_ action: Action?) {
        queue.sync { [weak self] in
            guard let strongSelf = self, let action = action else {
                return
            }
            strongSelf.state = strongSelf.reducer.reduce(action: action, state: strongSelf.state)
            print(strongSelf.state) // TODO: Move print to middleware
            DispatchQueue.main.async {
                strongSelf.listeners.forEach { $0.stateChanged(to: strongSelf.state) }
            }
        }
    }
}
