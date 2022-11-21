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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()

                ScrollView {
                    VStack {
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: "building.2")
                                    .frame(width: 30)
                                Text("Hello World")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .elementStyle()

                    }
                    .padding(.horizontal)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button{} label: { Label("Settings", systemImage: "gear") }
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
