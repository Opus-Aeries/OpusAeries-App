//
// Modifiers.swift
// AeriesUITesting
//
// Created by LeoSM_07 on 11/19/22.
//

import SwiftUI

extension View {
    func elementStyle() -> some View {
        modifier(ElementStyleModifier())
    }
    func primaryButton() -> some View {
        modifier(PrimaryButtonStyleModifier())
    }
}

struct PrimaryButtonStyleModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .bold()
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.accentColor)
            }
            .buttonStyle(.plain)
    }
}


struct ElementStyleModifier: ViewModifier {

    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .padding()
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("Detail"))
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.gray.opacity(0.3), lineWidth: 1)
                }

            }
            .shadow(color: .gray.opacity(colorScheme == .light ? 0.1 : 0), radius: 15)
    }
}
