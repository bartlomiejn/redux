//
//  AppDelegate.swift
//  redux-swift
//
//  Created by Bartłomiej Nowak on 29.04.2018.
//  Copyright © 2018 Bartłomiej Nowak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let store = StateStore(reducer: AppReducer(authenticationReducer: AuthenticationReducer()))
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = instantiateConfiguredAuthenticationController()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func instantiateConfiguredAuthenticationController() -> AuthenticationViewController? {
        let storyboard = UIStoryboard(name: "Authentication", bundle: Bundle(for: AuthenticationViewController.self))
        let controller = storyboard.instantiateInitialViewController() as? AuthenticationViewController
        controller?.presenter = AuthenticationPresenter(store: store, actionCreator: AuthenticationActionCreator())
        return controller
    }
}

