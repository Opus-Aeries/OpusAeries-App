//
// ForgotPasswordView.swift
// AeriesUITesting
//
// Created by LeoSM_07 on 11/19/22.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Binding var showView: Bool
    @State var emailText: String

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()

            VStack {

                Text("Reset Password")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

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
                    }
                }
                .elementStyle()

                Spacer()

                Button("Send Recovery Email"){}
                    .primaryButton()
            }
            .padding()
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ForgotPasswordView(showView: .constant(true), emailText: "")
        }
    }
}
