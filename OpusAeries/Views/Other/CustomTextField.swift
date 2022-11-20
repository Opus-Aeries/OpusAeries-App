//
// CustomTextField.swift
// AeriesUITesting
//
// Created by LeoSM_07 on 11/19/22.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let prompt: String
    let isPassword: Bool
    let contentType: UITextContentType?
    let keyboardStyle: UIKeyboardType

    @State private var showPassword = false

    init(
        text: Binding<String>,
        prompt: String,
        isPassword: Bool?,
        contentType: UITextContentType?,
        keyboardStyle: UIKeyboardType?
    ) {
        self._text = text
        self.prompt = prompt
        self.contentType = contentType
        self.isPassword = isPassword ?? false
        self.keyboardStyle = keyboardStyle ?? .default
    }

    @FocusState var isActive: Bool

    var body: some View {
        if contentType != nil && !isPassword {
            TextField(prompt, text: $text)
                .keyboardType(keyboardStyle)
                .textContentType(contentType!)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        } else if isPassword {
            if !showPassword {
                HStack {
                    SecureField(prompt, text: $text)
                        .keyboardType(.default)
                        .textContentType(.password)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    Button{ showPassword = true } label: {
                        Image(systemName: "eye")
                            .frame(width: 30)
                            .buttonStyle(.plain)
                            .foregroundColor(Color(uiColor: .tertiaryLabel))
                    }

                }
            } else if showPassword {
                HStack {
                    TextField(prompt, text: $text)
                        .keyboardType(.default)
                        .textContentType(.password)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    Button{ showPassword = false } label: {
                        Image(systemName: "eye.slash")
                            .frame(width: 30)
                            .buttonStyle(.plain)
                            .foregroundColor(Color(uiColor: .tertiaryLabel))
                    }
                }
            }


        } else {
            TextField(prompt, text: $text)
                .keyboardType(keyboardStyle)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }
    }

}
