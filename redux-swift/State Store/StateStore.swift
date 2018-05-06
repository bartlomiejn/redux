//
//  StateStore.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 04.05.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import Foundation

protocol StateBearer: class {
    var state: AppState { get }
}

protocol StateStoreDispatchInterface: StateBearer {
    func dispatch(_ action: Action)
}

protocol StateStoreListeningInterface: StateBearer {
    func subscribe(_ listener: StateStoreListener)
    func unsubscribe(_ listener: StateStoreListener)
}

class StateStore: StateStoreDispatchInterface, StateStoreListeningInterface {
    
    private let reducer: Reducer
    private (set) var state = AppState()
    private var listeners = [StateStoreListener]()
    private var middlewares = [Middleware]()
    private let queue = DispatchQueue(label: "State Store Dispatch Queue")
    
    init(reducer: Reducer, middlewares: [Middleware] = [LoggerMiddleware()]) {
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    /**
     Subscribe for state updates.
     */
    func subscribe(_ listener: StateStoreListener) {
        listeners.append(listener)
    }
    
    /**
     Unsubscribe from state updates.
     */
    func unsubscribe(_ listener: StateStoreListener) {
        guard let index = listeners.index(where: { $0 === listener }) else {
            return
        }
        listeners.remove(at: index)
    }
    
    /**
     Dispatch an action. State update is executed synchronously on internal queue for sequential updates. After state is
     reduced, listeners are asynchronously noticed of a state change on main queue. Middleware logic is executed before
     reduction.
     */
    func dispatch(_ action: Action) {
        middlewares.forEach { $0.process(action: action, store: self) }
        queue.sync { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.state = strongSelf.reducer.reduce(action: action, state: strongSelf.state)
            DispatchQueue.main.async {
                strongSelf.listeners.forEach { $0.stateChanged(to: strongSelf.state) }
            }
        }
    }
}
