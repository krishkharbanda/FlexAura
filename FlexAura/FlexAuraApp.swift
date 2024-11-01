//
//  FlexAuraApp.swift
//  FlexAura
//
//  Created by Krish on 10/27/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
struct FlexAuraApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var habitat = Habitat()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(habitat)
        }
    }
}
