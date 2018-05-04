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

class StateStore {
    
    typealias ReducerFunctionType = (Action, AppState?) -> AppState
    
    private (set) var state = AppState()
    private (set) var observers = [StateStoreObserver]()
    private let reduce: ReducerFunctionType
    
    init(reduce: @escaping ReducerFunctionType) {
        self.reduce = reduce
    }
    
    func subscribe(withObserver observer: StateStoreObserver) {
        observers.append(observer)
    }
    
    func dispatch(action: Action) {
        state = reduce(action, state)
        observers.forEach { $0.stateChanged(to: state) }
    }
}

protocol StateStoreObserver {
    var store: StateStore! { get }
    func stateChanged(to state: AppState)
}
