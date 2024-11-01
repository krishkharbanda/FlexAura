//
//  View++Extension.swift
//  FlexAura
//
//  Created by Krish on 10/29/24.
//

import Foundation
import SwiftUI
import UIKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
