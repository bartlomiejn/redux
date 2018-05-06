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

protocol StateStoreObserver: class {
    func stateChanged(to state: AppState)
}

// TODO: Middleware implementation
protocol Middleware: class {
    func apply(to action: Action, store: StateStore, next: Middleware)
}

class StateStore {
    
    typealias ReducerFunctionType = (Action, AppState?) -> AppState
    
    private let reducer: AppReducer
    private let queue = DispatchQueue(label: "State Store Dispatch Queue")
    private (set) var state = AppState()
    private var observers = [StateStoreObserver]()
    
    init(reducer: AppReducer) {
        self.reducer = reducer
    }
    
    func subscribe(withObserver observer: StateStoreObserver) {
        observers.append(observer)
    }
    
    func unsubscribe(observer: StateStoreObserver) {
        guard let index = observers.index(where: { $0 === observer }) else {
            return
        }
        observers.remove(at: index)
    }
    
    func dispatch(_ action: Action?) {
        queue.sync { [weak self] in
            guard let strongSelf = self, let action = action else {
                return
            }
            strongSelf.state = strongSelf.reducer.reduce(action: action, state: strongSelf.state)
            print(strongSelf.state)
            DispatchQueue.main.async {
                strongSelf.observers.forEach { $0.stateChanged(to: strongSelf.state) }
            }
        }
    }
    
    func dispatch(_ createAction: (StateStore, AppState) -> Action?) {
        dispatch(createAction(self, state))
    }
    
    func dispatchAsync(_ asyncCreateAction: (StateStore, AppState, @escaping (Action?) -> Void) -> Void) {
        asyncCreateAction(self, state) { [weak self] action in
            self?.dispatch(action)
        }
    }
}
