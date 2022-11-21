//
// GradeView.swift
// AeriesUITesting
//
// Created by LeoSM_07 on 11/19/22.
//

import AeriesKit
import SwiftUI

struct GradeView: View {

    @EnvironmentObject var aeries: AeriesViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 15) {
                        sectionHeader("Active Classes")
                        ForEach(aeries.coursesSummary.filter{$0.gradebookLink != nil && $0.currentMark != ""}, id: \.self) { item in
                            NavigationLink(value: item) {
                                GradeCard(course: item)
                                    .elementStyle()
                            }
                            .buttonStyle(.plain)

                        }

                        Spacer().frame(height: 20)

                        sectionHeader("Inactive Classes")

                        ForEach(aeries.coursesSummary.filter{$0.gradebookLink == nil || $0.currentMark == ""}, id: \.self) { item in
                            GradeCard(course: item)
                                .elementStyle()
                        }


                    }
                    .padding(.horizontal)
                }

                if aeries.coursesSummary == [] {
                    Text("No Courses")
                }
            }
            .navigationTitle("Grades")
            .navigationDestination(for: AeriesClassSummary.self) { summary in
                GradebookDetailView(courseSummary: summary)
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
        }
    }

    @ViewBuilder func sectionHeader(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, -10)
    }
}

struct GradeCard: View {

    let course: AeriesClassSummary

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(course.courseName)
                        .font(.title2.bold())
//                        .fontDesign(.rounded)e
                        .foregroundColor(Color("AccentBlue"))
                    Text(course.teacherName + "  -  " + course.roomNumber)
                    Spacer()
                }

                Spacer()
                VStack(alignment: .trailing) {
                    Text(course.currentMark)
                        .font(.largeTitle.bold())
                        .foregroundColor(determineGradeColor(course.currentMark))
//                    Text(percent+"%")
//                        .font(.caption)
                }
                .frame(width: 50, alignment: .trailing)

                Image(systemName: "chevron.right")
                    .foregroundColor(Color(uiColor: .tertiaryLabel))
            }
        }
        .frame(maxWidth: .infinity)
    }

    func determineGradeColor(_ grade: String) -> Color {
        if grade.contains("A") {
            return Color("GradeGreen")
        } else if grade.contains("B") {
            return Color("GradeLightGreen")
        } else if grade.contains("C") {
            return Color("GradeYellow")
        } else if grade.contains("D") {
            return Color("GradeOrange")
        } else if grade.contains("F") {
            return Color("GradeRed")
        } else {
            return .gray
        }
    }
}

struct GradeView_Previews: PreviewProvider {
    static var previews: some View {
        GradeView()
    }
}
