//
//  ContentView.swift
//  OpusAeries
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var aeries: AeriesViewModel

    var body: some View {
        switch aeries.currentlyAuthenticated {
        case true:
            MainView()
        case false:
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
