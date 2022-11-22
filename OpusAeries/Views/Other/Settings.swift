//
//  Settings.swift
//  OpusAeries
//
//  Created by Ben on 11/21/22.
//

import AeriesKit
import SwiftUI
import RegexBuilder

struct SettingsView: View{
    
    @Binding var showSettings: Bool
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("Background")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack{
                        VStack(spacing: 15){
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
            .navigationTitle("Settings")
        }
    }
    
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
