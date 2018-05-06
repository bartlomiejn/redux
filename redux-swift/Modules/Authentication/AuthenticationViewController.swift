//
//  AuthenticationViewController.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 29.04.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    var presenter: AuthenticationPresenter!
    
    @IBOutlet private (set) weak var usernameField: UITextField!
    @IBOutlet private (set) weak var passwordField: UITextField!
    
    @IBAction private func textChanged(_ sender: UITextField) {
        if sender == usernameField, let text = sender.text {
            presenter.usernameChanged(to: text)
        } else if sender == passwordField, let text = sender.text {
            presenter.passwordChanged(to: text)
        }
    }
    
    @IBAction private func signIn() {
        presenter.tappedSignIn()
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
