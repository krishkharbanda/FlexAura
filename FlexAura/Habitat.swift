//
//  Habitat.swift
//  FlexAura
//
//  Created by Krish on 10/28/24.
//

import Foundation
import SwiftUI

class Habitat: ObservableObject {
    
    // MARK: vars
    @Published var appState: AppState = .home
}

// MARK: AppState
enum AppState: CaseIterable {
    case onboarding
    case home
}

// MARK: User
struct User {
    var name: String
    var email: String
    var provider: Provider
    var height: Int
    var weight: Int
    var gender: Gender
    var injuredJoint: InjuredJoint
    var side: Side
    var baseROM: Int
    var targetROM: Int
    
    init() {
        self.name = ""
        self.email = ""
        self.provider = .email
        self.height = 0
        self.weight = 0
        self.gender = .other
        self.injuredJoint = .knee
        self.side = .left
        self.baseROM = 0
        self.targetROM = 0
    }
    
    init(name: String, email: String, provider: Provider, height: Int, weight: Int, gender: Gender, injuredJoint: InjuredJoint, side: Side, baseROM: Int, targetROM: Int) {
        self.name = name
        self.email = email
        self.provider = provider
        self.height = height
        self.weight = weight
        self.gender = gender
        self.injuredJoint = injuredJoint
        self.side = side
        self.baseROM = baseROM
        self.targetROM = targetROM
    }
}

// MARK: Providers
enum Provider: String, CaseIterable {
    case email = "Email/Password"
    case apple = "Apple"
    case google = "Google"
}

// MARK: Gender
enum Gender: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case male = "Male"
    case female = "Female"
    case other = "Other"
}

// MARK: InjuredJoint
enum InjuredJoint: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case knee = "Knee"
    case shoulder = "Shoulder"
    case elbow = "Elbow"
}

enum Side: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case left = "Left"
    case right = "Right"
}
