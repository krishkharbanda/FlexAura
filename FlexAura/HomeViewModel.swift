//
//  HomeViewModel.swift
//  FlexAura
//
//  Created by Krish on 11/1/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var currentPercentage: Double = 0

    var animation: Animation {
        Animation.easeInOut(duration: 1)
    }
}
