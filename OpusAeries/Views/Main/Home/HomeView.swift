//
// HomeView.swift
// AeriesUITesting
//
// Created by LeoSM_07 on 11/19/22.
//

import AeriesKit
import SwiftUI
import RegexBuilder

struct HomeView: View {
    
    @State var showSettings = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()

                ScrollView {
                    VStack {
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: "paintpalette.fill")
                                    .frame(width: 30)
                                Text("Color Picker")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .elementStyle()

                    }
                    .padding(.horizontal)
                }
            }
            .sheet(isPresented: $showSettings, content: {
                SettingsView(showSettings: $showSettings)
                //Text("settings view")
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button{
                            showSettings = true
                        } label: { Label("Settings", systemImage: "gear") }
                    } label: {
                        Image(systemName: "person.fill")
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
