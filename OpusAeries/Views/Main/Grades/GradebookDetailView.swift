//
// GradebookDetailView.swift
// OpusAeries
//
// Created by LeoSM_07 on 11/20/22.
//

import AeriesKit
import SwiftUI

struct GradebookDetailView: View {
    @Environment(\.colorScheme) var colorScheme
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
                            Spacer()
                            VStack {
                                Text("Total Grade")
                                    .font(.headline)
                                Spacer()
                                Text(courseSummary.percent)

                            }
                            Spacer()
                            Spacer()
                            Spacer()
                            Text(courseSummary.currentMark)
                                .font(.largeTitle)
                                .bold()
                            Spacer()
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.accentColor.gradient)
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.gray.opacity(1), lineWidth: 1)
                        }

                    }
                    .shadow(color: .gray.opacity(colorScheme == .light ? 0.1 : 0), radius: 15)

                    if gradebook != [] {
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(gradebook, id: \.self) { entry in
                                Text(entry.description)
                                Divider()
                            }
                        }
                        .elementStyle()
                    }

                }
                .padding(.horizontal)
            }

            if gradebook == [] {
                VStack {
                    ProgressView()
                    Text("Loading")
                }
                .padding(20)
                .background(Color(uiColor: .systemBackground))
                .cornerRadius(10)
            }
        }
        .navigationTitle(courseSummary.courseName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let link = courseSummary.gradebookLink {
                aeries.aeries.getGradebookDetails(
                    url: "\(aeries.aeries.baseUrl)Student/\(link)",
                    extraPrint: true
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
