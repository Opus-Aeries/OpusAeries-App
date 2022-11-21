//
// TutorialView.swift
// PopoverTests
//
// Created by LeoSM_07 on 9/1/22.
//

import Popovers
import SwiftUI

struct OnboardingView: View {
    @Binding var isOpen: Bool
    @State var step: Int = 0

    var body: some View {
        VStack {
            VStack {
                HStack {

                    if step > 0 {
                        Button {
                            if step > 0 { step -= 1 }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 19))
                                .foregroundColor(.secondary)
                                .frame(width: 30, height: 30)
                                .background(Color(uiColor: .systemBackground))
                                .cornerRadius(19)
                        }
                    }

                    Spacer()

                    Button {
                        isOpen = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 19))
                            .foregroundColor(.secondary)
                            .frame(width: 30, height: 30)
                            .background(Color(uiColor: .systemBackground))
                            .cornerRadius(19)
                    }
                }
                if step == 0 {
                    VStack {
                        ZStack {
                            Image("LogoRounded")
                                .resizable()
                                .scaledToFit()
                                .blur(radius: 10)
                                .opacity(0.8)
                            Image("LogoRounded")
                                .resizable()
                                .scaledToFit()

                        }
                        .padding(.horizontal, 85)

                        Text("Welcome to Opus-Aeries")
                            .font(.largeTitle.bold())
                            .padding(.bottom, 2)

                        Text("Your Grades Streamlined")
                            .font(.subheadline)
                            .italic()


                        Spacer()

                        nextButton(1)

                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))

                } else if step == 1 {
                    VStack {
                        ZStack {
                            Image(systemName: "ladybug.fill")
                                .resizable()
                                .scaledToFit()
                                .blur(radius: 10)
                                .opacity(0.3)
                            Image(systemName: "ladybug.fill")
                                .resizable()
                                .scaledToFit()

                        }
                        .padding(.horizontal, 85)
                        .foregroundColor(.accentColor)


                        Spacer()
                        Spacer()

                        Text("No More Bugs")
                            .font(.largeTitle.bold())
                            .padding(.bottom, 2)

                        Spacer()

                        Text("Built for stability, you can rely on this app. No more crashes.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)


                        Spacer()
                        Spacer()

                        nextButton(2)

                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                } else if step == 2 {
                    VStack {
                        ZStack {
                            Image(systemName: "person.badge.shield.checkmark.fill")
                                .resizable()
                                .scaledToFit()
                                .blur(radius: 10)
                                .opacity(0.3)
                            Image(systemName: "person.badge.shield.checkmark.fill")
                                .resizable()
                                .scaledToFit()

                        }
                        .padding(.horizontal, 85)
                        .foregroundColor(.accentColor)

                        Spacer()
                        Spacer()

                        Text("Privacy In Mind")
                            .font(.largeTitle.bold())
                            .padding(.bottom, 2)

                        Spacer()

                        Text("Your data never leaves the app and can not be seen by anyone.\n[Learn More](https://github.com/Opus-Aeries/OpusAeries-App)")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)


                        Spacer()
                        Spacer()

                        nextButton(3)

                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                } else if step == 3 {
                    VStack {
                        ZStack {
                            Image(systemName: "building.columns.fill")
                                .resizable()
                                .scaledToFit()
                                .blur(radius: 10)
                                .opacity(0.3)
                            Image(systemName: "building.columns.fill")
                                .resizable()
                                .scaledToFit()

                        }
                        .padding(.horizontal, 85)
                        .foregroundColor(.accentColor)

                        Spacer()
                        Spacer()

                        Text("Same Old Aeries")
                            .font(.largeTitle.bold())
                            .padding(.bottom, 2)

                        Spacer()

                        Text("Use your regular Aeries email & password to login to Opus-Aeries.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)


                        Spacer()
                        Spacer()

                        Button {
                            withAnimation(.spring()) {
                                isOpen = false
                            }
                        } label: {
                            HStack {
                                Text("Get Started")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(10)
                            .padding(.horizontal, 30)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.accentColor)
                            }
                        }
                        .buttonStyle(.plain)

                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                } else {
                    Spacer()
                }
            }
            .padding(15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.thickMaterial)
        .cornerRadius(16)
        .popoverShadow(shadow: .system)
    }

    @ViewBuilder
    func nextButton(_ next: Int) -> some View{
        Button {
            withAnimation(.spring()) {
                step = next
            }
        } label: {
            HStack {
                Text("Next")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding(10)
            .padding(.horizontal, 50)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.accentColor)
            }
        }
        .buttonStyle(.plain)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AeriesViewModel())
    }
}
