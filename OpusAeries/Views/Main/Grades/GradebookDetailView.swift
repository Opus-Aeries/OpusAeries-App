//
// GradebookDetailView.swift
// OpusAeries
//
// Created by LeoSM_07 on 11/20/22.
//

import AeriesKit
import SwiftUI

struct GradebookDetailView: View {
    @EnvironmentObject var aeries: AeriesViewModel
    let courseSummary: AeriesClassSummary

    @State var gradebook: [AeriesGradeBookEntry] = []

    var body: some View {
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

                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(gradebook, id: \.self) { entry in
                            Text(entry.description)
                            Divider()
                        }
                    }
                    .elementStyle()

                }
                .padding(.horizontal)
            }

            if gradebook == [] {
                VStack {
                    ProgressView()
                    Text("Loading")
                }
                .padding(20)
                .background(.regularMaterial)
                .cornerRadius(10)
            }
        }
        .navigationTitle("Home")
        .onAppear {
            if let link = courseSummary.gradebookLink {
                aeries.aeries.getGradebookDetails(
                    url: "\(aeries.aeries.baseUrl)Student/\(link)",
                    extraPrint: false
                ) { result in
                    switch result {
                    case .success(let item):
                        gradebook = item
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}
