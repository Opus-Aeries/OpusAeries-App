//
// LoginView.swift
// AeriesUITesting
//
// Created by LeoSM_07 on 11/19/22.
//

import Popovers
import SwiftUI

struct LoginView: View {

    @EnvironmentObject var aeries: AeriesViewModel
    @EnvironmentObject var settings: UserPreferencesManager

    @State var showResetPassword = false
    @State var emailText: String = ""
    @State var passwordText: String = ""

    @State var presentOnboardingPopover = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()

                VStack {

                    Spacer()
                        .frame(height: 150)

                    Text("Login")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // MARK: Input Fields
                    VStack(spacing: 15) {
                        HStack {
                            Image(systemName: "building.2")
                                .frame(width: 30)
                            Menu("Santa Monica Malibu Unified"){
                                Button("Santa Monica Malibu Unified"){}
                                Button{} label: {
                                    Label("Add Other", systemImage: "plus")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Divider()
                        HStack {
                            Image(systemName: "envelope")
                                .font(.title2)
                                .frame(width: 30)
                            CustomTextField(
                                text: $emailText,
                                prompt: "Email",
                                isPassword: false,
                                contentType: .emailAddress,
                                keyboardStyle: .emailAddress
                            )
                            .onSubmit {
                                submit()
                            }
                            .submitLabel(.done)
                        }
                        Divider()
                        HStack {
                            Image(systemName: "lock")
                                .font(.title2)
                                .frame(width: 30)
                            CustomTextField(
                                text: $passwordText,
                                prompt: "Password",
                                isPassword: true,
                                contentType: .password,
                                keyboardStyle: .default
                            )
                            .onSubmit {
                                submit()
                            }
                            .submitLabel(.done)

                            if aeries.canUseBiometrics {
                                Button {
                                    submit()
                                } label: {
                                    Image(systemName: aeries.authentication.biometricType() == .face ? "faceid" : "touchid")
                                }
                            }

                        }
                    }
                    .elementStyle()

                    // MARK: Buttons
                    Button("Forgot Password") {
                        // Functionality not implemented
                        // showResetPassword = true
                        presentOnboardingPopover = true
                    }
                    .font(.subheadline)
                    .padding(.trailing, 5)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                    Spacer()
                        .frame(height: 50)


                    Button{ submit() } label: {
                        HStack(spacing: 20) {
                            if aeries.signInLoading {
                                ProgressView()
                                    .foregroundColor(.white)
                            }
                            Text("Sign In")
                        }
                    }
                    .disabled(aeries.signInLoading)
                    .primaryButton()

                    Spacer()
                }
                .padding(.horizontal)

            }
            .sheet(isPresented: $showResetPassword) {
                ForgotPasswordView(showView: $showResetPassword, emailText: emailText)
                    .presentationDetents([.height(300)])
            }
            .alert("Error Logging In", isPresented: $aeries.showError, actions: {
                Button("Ok") {
                    aeries.showError = false
                    aeries.errorMessage = ""
                }
            }, message: {
                Text(aeries.errorMessage)
            })
            .onAppear {
                #warning("Add Back When Done")
//                if settings.automaticallyUseFaceId && aeries.canUseBiometrics {
//                    submit()
//                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.visible)
            .popover(
                present: $presentOnboardingPopover,
                attributes: {
                    $0.position = .relative(
                        popoverAnchors: [
                            .center,
                        ]
                    )

                    let animation = Animation.spring(
                        response: 0.6,
                        dampingFraction: 0.8,
                        blendDuration: 1
                    )
                    let transition = AnyTransition.move(edge: .bottom).combined(with: .opacity)

                    $0.presentation.animation = animation
                    $0.presentation.transition = transition
                    $0.dismissal.mode = []
                }
            ) {
                OnboardingView(isOpen: $presentOnboardingPopover)
                    .frame(maxWidth: 325, maxHeight: 400)
            }
        }
    }

    func submit() {
        aeries.loginUser(email: emailText, password: passwordText)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AeriesViewModel())
    }
}
