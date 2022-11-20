//
//  OpusAeriesApp.swift
//  OpusAeries
//


import SwiftUI

@main
struct OpusAeriesApp: App {

    @StateObject var userPreferencesManager = UserPreferencesManager()
    @StateObject var aeriesViewModel = AeriesViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userPreferencesManager)
                .environmentObject(aeriesViewModel)
        }
    }
}
