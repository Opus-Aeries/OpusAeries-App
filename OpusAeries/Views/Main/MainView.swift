//
// MainView.swift
// AeriesUITesting
//
// Created by LeoSM_07 on 11/19/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var aeries: AeriesViewModel

    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
            GradeView()
                .tabItem { Label("Grades", systemImage: "envelope.open") }
            Text("Attendance")
                .tabItem { Label("Attendance", systemImage: "hand.raised") }
            Text("Report Cards")
                .tabItem { Label("Report Cards", systemImage: "mail.stack") }
        }
        .onAppear {
            aeries.getCourseSummary()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainView()
        }
    }
}
