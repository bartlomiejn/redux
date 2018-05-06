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

    private struct Constant {
        static let `protocol` = "https"
        static let host = "api.github.com"
        static let timeoutInterval = 20.0
    }
    
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
        let client = GitHubNetworkClient(
            client: HTTPNetworkClient(
                timeoutInterval: Constant.timeoutInterval,
                generator: URLGenerator(protocol: Constant.protocol, host: Constant.host)
            ),
            store: store)
        let actionCreator = AuthenticationActionCreator(service: AuthenticationService(client: client))
        controller?.presenter = AuthenticationPresenter(store: store, actionCreator: actionCreator)
        return controller
    }
}

