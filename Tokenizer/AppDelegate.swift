//
//  AppDelegate.swift
//  Tokenizer
//
//  Created by Attaallah Ayman, Vodafone on 08/01/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewModel = TokenizerViewModel(tokenizeEngine: TokenizeEngine())
        let mainVC = TokenizerViewController(viewModel: viewModel)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainVC
        
        return true
    }
}

