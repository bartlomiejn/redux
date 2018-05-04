//
//  AuthenticationViewController.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 29.04.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    var store: StateStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AuthenticationViewController: StateStoreObserver {
    
    func stateChanged(to state: AppState) {
        
    }
}

