//
//  ContentView.swift
//  FlexAura
//
//  Created by Krish on 10/27/24.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    // MARK: VM
    @EnvironmentObject var habitat: Habitat
    
    // MARK: body
    var body: some View {
        ZStack {
            switch habitat.appState {
            case .onboarding:
                OnboardingView()
                    .environmentObject(habitat)
            case .home:
                HomeView()
                    .environmentObject(habitat)
            }
        }
        .task {
            var context = LAContext()
            context.localizedCancelTitle = "Cancel"
            
            var error: NSError?
            guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
                print(error?.localizedDescription ?? "Can't evaluate policy")
                return
            }
            
            Task {
                do {
                    try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Log in to your account")
                    habitat.appState = .home
                } catch let error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
    }
}

// MARK: Preview
#Preview {
    ContentView()
}
