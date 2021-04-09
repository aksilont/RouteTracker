//
//  AppDelegate.swift
//  Route Tracker
//
//  Created by Aksilont on 04.04.2021.
//

import UIKit
import GoogleMaps
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let googleMapsAPIKey = "AIzaSyBvYtiunwLTU9lSDLole2JwDiITJrVs5gg"
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(googleMapsAPIKey)
        
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
        print(config.fileURL ?? "")
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
