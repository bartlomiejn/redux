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
    
    @IBOutlet private (set) weak var usernameField: UITextField!
    @IBOutlet private (set) weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func signIn() {
        
    }
}

extension AuthenticationViewController: StateStoreObserver {
    
    func stateChanged(to state: AppState) {
        
    }
}

extension AuthenticationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            passwordField.resignFirstResponder()
        }
        return true
    }
}
