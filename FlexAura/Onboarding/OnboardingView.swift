//
//  OnboardingView.swift
//  FlexAura
//
//  Created by Krish on 10/27/24.
//

import SwiftUI

struct OnboardingView: View {
    
    // MARK: VMs
    @EnvironmentObject var habitat: Habitat
    @StateObject private var viewModel = OnboardingViewModel()

    // MARK: vars
    @State private var existingAccount = false
    @State private var isPasswordVisible = false
    
    // MARK: body
    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .foregroundStyle(.background)
            switch viewModel.onboardingState {
            case .start:
                startView
            case .profileSignUp:
                if existingAccount {
                    profileSignInView
                } else {
                    profileSignUpView
                }
            case .requestAccess:
                requestAccessView
            case .additionalInfo:
                additionalInfoView
            }
        }
        .padding()
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    // MARK: startView
    var startView: some View {
        VStack(spacing: 30) {
            Spacer()
            VStack {
                Text("Welcome to FlexAura!")
                    .font(.largeTitle)
                    .bold()
                Text("Thank you for choosing us as your partner in mobility recovery! Follow the steps below to get started on your journey toward better mobility and improved health.")
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            let steps = [["person.crop.circle", "Set up your account", "Create a profile with your desired provider to secure your data."], ["widget.large", "Add additional information", "Add additional information to personalize your tracking even further."], ["heart.fill", "Authorize health access", "Allow the necessary fields to better track and incorporate Health into your progress."]]
            LazyVStack {
                ForEach(steps, id: \.self) { step in
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: step[0])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35)
                        VStack(alignment: .leading) {
                            Text(step[1])
                                .fontWeight(.medium)
                            Text(step[2])
                                .font(.caption)
                        }
                        Spacer()
                    }
                    .foregroundStyle(.accent)
                    .padding()
                }
            }
            
            Spacer()
            
            Button {
                viewModel.onboardingState = .profileSignUp
            } label: {
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                        .foregroundStyle(.accent)
                    Text("Continue")
                        .foregroundStyle(.white)
                        .bold()
                }
                .frame(height: 55)
            }
        }
    }
    
    // MARK: profileSignUpView
    var profileSignUpView: some View {
        VStack(spacing: 30) {
            Spacer()
            VStack {
                Text("Create an account")
                    .font(.largeTitle)
                    .bold()
                Text("Sign up with your desired provider to better secure your data and personalize your app experience.")
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            
            VStack(spacing: 7.5) {
                CustomTextField(titleKey: "Name", text: $viewModel.user.name)
                CustomTextField(titleKey: "Email", text: $viewModel.user.email)
                    .keyboardType(.emailAddress)
                ZStack {
                    if isPasswordVisible {
                        CustomTextField(titleKey: "Password", text: $viewModel.password)
                    } else {
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(.textField)
                            .cornerRadius(15)
                            .onSubmit {
                                self.hideKeyboard()
                            }
                    }
                    HStack {
                        Spacer()
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye.fill":"eye.slash.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.gray)
                                .frame(height: 15)
                        }
                        .padding()
                    }
                }
                .padding(.bottom)
                Button("Have an existing account? Sign in.") {
                    existingAccount = true
                }
            }
            
            VStack {
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                            .foregroundStyle(.accent)
                        HStack(alignment: .center) {
                            Image("googlelogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 17)
                            Text("Sign up with Google")
                                .foregroundStyle(.white)
                                .bold()
                        }
                    }
                    .frame(height: 55)
                }
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                            .foregroundStyle(.accent)
                        HStack(alignment: .center) {
                            Image(systemName: "applelogo")
                                .resizable()
                                .foregroundStyle(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                            Text("Sign up with Apple")
                                .foregroundStyle(.white)
                                .bold()
                        }
                    }
                    .frame(height: 55)
                }
            }
                
            Spacer()
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                        .foregroundStyle((viewModel.user.name.isEmpty || viewModel.user.email.isEmpty || viewModel.password.isEmpty) ? .textField : .accent)
                    Text("Continue")
                        .foregroundStyle((viewModel.user.name.isEmpty || viewModel.user.email.isEmpty || viewModel.password.isEmpty) ? .label.opacity(0.6) : .white)
                        .bold()
                }
                .frame(height: 55)
            }
            .disabled(viewModel.user.name.isEmpty || viewModel.user.email.isEmpty || viewModel.password.isEmpty)
        }
    }
    
    // MARK: profileSignInView
    var profileSignInView: some View {
        VStack(spacing: 30) {
            Spacer()
            VStack {
                Text("Sign into your account")
                    .font(.largeTitle)
                    .bold()
                Text("Sign in with your desired provider to access your data and personalize your app experience.")
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            
            VStack(spacing: 7.5) {
                CustomTextField(titleKey: "Email", text: $viewModel.user.email)
                    .keyboardType(.emailAddress)
                ZStack {
                    if isPasswordVisible {
                        CustomTextField(titleKey: "Password", text: $viewModel.password)
                    } else {
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(.textField)
                            .cornerRadius(15)
                            .onSubmit {
                                self.hideKeyboard()
                            }
                    }
                    HStack {
                        Spacer()
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye.fill":"eye.slash.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.gray)
                                .frame(height: 15)
                        }
                        .padding()
                    }
                }
                .padding(.bottom)
                Button("Don't have an existing account? Sign up.") {
                    existingAccount = false
                }
            }
            
            VStack {
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                            .foregroundStyle(.accent)
                        HStack(alignment: .center) {
                            Image("googlelogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 17)
                            Text("Sign in with Google")
                                .foregroundStyle(.white)
                                .bold()
                        }
                    }
                    .frame(height: 55)
                }
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                            .foregroundStyle(.accent)
                        HStack(alignment: .center) {
                            Image(systemName: "applelogo")
                                .resizable()
                                .foregroundStyle(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                            Text("Sign in with Apple")
                                .foregroundStyle(.white)
                                .bold()
                        }
                    }
                    .frame(height: 55)
                }
            }
            
            Spacer()
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                        .foregroundStyle((viewModel.user.name.isEmpty || viewModel.user.email.isEmpty || viewModel.password.isEmpty) ? .textField : .accent)
                    Text("Continue")
                        .foregroundStyle((viewModel.user.name.isEmpty || viewModel.user.email.isEmpty || viewModel.password.isEmpty) ? .label.opacity(0.6) : .white)
                        .bold()
                }
                .frame(height: 55)
            }
            .disabled(viewModel.user.name.isEmpty || viewModel.user.email.isEmpty || viewModel.password.isEmpty)
        }
    }
    
    // MARK: requestAccessView
    var requestAccessView: some View {
        VStack(spacing: 30) {
            
            Spacer()
            
            VStack {
                Text("Request Access")
                    .font(.largeTitle)
                    .bold()
                Text("Allow access to Health for certain fields to help with accurately measuring motion and tracking your progress.")
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                        .foregroundStyle(.accent)
                    Text("Allow access")
                        .foregroundStyle(.white)
                        .bold()
                }
                .frame(height: 55)
            }
        }
    }
    
    // MARK: additionalInfoView
    
    // MARK: Int Strings
    @State private var height = String()
    @State private var weight = String()
    @State private var baseROM = String()
    @State private var targetROM = String()
    
    var additionalInfoView: some View {
        VStack(spacing: 30) {
            Spacer()
            VStack {
                Text("Additional Info")
                    .font(.largeTitle)
                    .bold()
                Text("Enter the additional information to help with accurately measuring motion and tracking your progress.")
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            
            VStack {
                HStack {
                    Text("GENERAL INFO")
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    CustomTextField(titleKey: "Height (in)", text: $height)
                    CustomTextField(titleKey: "Weight (lbs)", text: $weight)
                }
                Picker("Gender", selection: $viewModel.user.gender) {
                    ForEach(Gender.allCases) { gender in
                        Text(gender.rawValue)
                    }
                }
                .pickerStyle(.palette)
                .padding(.bottom, 10)
            }
            
            VStack {
                HStack {
                    Text("INJURED JOINT")
                        .font(.headline)
                    Spacer()
                }
                Picker("Side", selection: $viewModel.user.side) {
                    ForEach(Side.allCases) { side in
                        Text(side.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                Picker("Injured Joint", selection: $viewModel.user.injuredJoint) {
                    ForEach(InjuredJoint.allCases) { joint in
                        Text(joint.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            VStack {
                HStack {
                    Text("RANGE OF MOTION")
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    CustomTextField(titleKey: "Current ROM (degrees)", text: $baseROM)
                    Text("to")
                    CustomTextField(titleKey: "Target ROM (degrees)", text: $targetROM)
                }
            }
            
            Spacer()
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                        .foregroundStyle((viewModel.user.height == 0 || viewModel.user.weight == 0 || viewModel.user.baseROM == 0 || viewModel.user.targetROM == 0) ? .textField : .accent)
                    Text("Continue")
                        .foregroundStyle((viewModel.user.height == 0 || viewModel.user.weight == 0 || viewModel.user.baseROM == 0 || viewModel.user.targetROM == 0) ? .label.opacity(0.6) : .white)
                        .bold()
                }
                .frame(height: 55)
            }
            .disabled(viewModel.user.height == 0 || viewModel.user.weight == 0 || viewModel.user.baseROM == 0 || viewModel.user.targetROM == 0)
        }
        .keyboardType(.numberPad)
        .onChange(of: height) { oldValue, newValue in
            if let new = Int(newValue) {
                viewModel.user.height = new
            }
        }
        .onChange(of: weight) { oldValue, newValue in
            if let new = Int(newValue) {
                viewModel.user.weight = new
            }
        }
        .onChange(of: baseROM) { oldValue, newValue in
            if let new = Int(newValue) {
                viewModel.user.baseROM = new
            }
        }
        .onChange(of: targetROM) { oldValue, newValue in
            if let new = Int(newValue) {
                viewModel.user.targetROM = new
            }
        }
    }
}

// MARK: Preview
#Preview {
    OnboardingView()
}
