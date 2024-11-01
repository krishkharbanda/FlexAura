//
//  CustomTextField.swift
//  FlexAura
//
//  Created by Krish on 10/29/24.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    
    @State var titleKey: String
    @Binding var text: String
    
    var body: some View {
        TextField(titleKey, text: $text)
            .padding()
            .background(.textField)
            .cornerRadius(15)
            .onSubmit {
                self.hideKeyboard()
            }
    }
    
}
