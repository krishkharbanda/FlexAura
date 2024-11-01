//
//  OnboardingViewModel.swift
//  FlexAura
//
//  Created by Krish on 10/27/24.
//

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    
    // MARK: vars
    @Published var onboardingState: OnboardingState = .start
    @Published var user = User()
    @Published var password = String()
    
}

// MARK: OnboardingState
enum OnboardingState: CaseIterable {
    case start
    case profileSignUp
    case requestAccess
    case additionalInfo
}
