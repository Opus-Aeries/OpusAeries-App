//
// AeriesViewModel.swift
// OpusAeries
//

import AeriesKit
import SwiftUI

class AeriesViewModel: ObservableObject {
    var authentication = AuthenticationManager()
    var aeries = AeriesKit(baseUrl: "https://santamonicamalibu.aeries.net/")
    @AppStorage("storedUserEmail") var userEmail: String = ""

    // Login Items
    @Published var errorMessage: String = ""
    @Published var showError =  false
    @Published var currentlyAuthenticated = false
    @Published var signInLoading = false

    // Data Items
    @Published var coursesSummary: [AeriesClassSummary] = []

    /// Determines if there is existing data to use with biometric unlock
    var canUseBiometrics: Bool {
        if userEmail != "" && authentication.biometricType() != .none {
            return true
        } else {
            return false
        }
    }

    func getCourseSummary() {
        aeries.requestJsonData(
            endpoint: "Student/Widgets/ClassSummary/GetClassSummary?IsProfile=True&_=1668880527555",
            model: [AeriesClassSummary].self
        ) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.coursesSummary = data
                    }
                case .failure(let error):
                    self.handleFailure(error)
                }
            }
    }

    func loginUser(email: String, password: String) {
        if userEmail == "" || email != "" && password != "" {
            signInLoading = true
            checkLoginWithAeries(email: email, password: password)
        } else if userEmail != "" {
            authentication.requestBiometricUnlock(email: userEmail) { result in
                switch result {
                case .success(let password):
                    self.signInLoading = true
                    self.checkLoginWithAeries(email: self.userEmail, password: password)
                case .failure(let error):
                    self.handleFailure(error)
                }
            }
        } else {
            signInLoading = true
            checkLoginWithAeries(email: email, password: password)
        }
    }

    private func checkLoginWithAeries(email: String, password: String) {
        aeries.login(email: email, password: password) { result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self.signInLoading = false
                    self.currentlyAuthenticated = true
                    do {
                        try KeychainManager().saveUserPassword(email: email, password: password)
                        self.userEmail = email
                    } catch {
                        print(error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.handleFailure(error)
                }
                print(error.localizedDescription)
            }
        }
    }

    private func handleFailure(_ error: Error) {
        self.errorMessage = error.localizedDescription
        self.showError = true
        print(error.localizedDescription)
    }
}
