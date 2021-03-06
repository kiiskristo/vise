//
//  AppDelegate.swift
//  LeFood
//
//  Created by Kristo Kiis on 02.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import ParseSwift
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupStripe()
        setupParse()
        return true
    }

    private func setupStripe() {
        Stripe.setDefaultPublishableKey("")
        STPPaymentConfiguration.shared().appleMerchantIdentifier = ""
    }

    private func setupParse() {
        ParseSwift.initialize(applicationId: "",
                              clientKey: "",
                              serverURL: URL(string: "")!)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

