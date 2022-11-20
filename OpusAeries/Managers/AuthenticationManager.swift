//
// AuthenticationManager.swift
// OpusAeries
//

import LocalAuthentication
import SwiftUI

class AuthenticationManager: ObservableObject {

    enum BiometricType {
        case none
        case touch
        case face
    }

    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case deniedAccess
        case noFaceIdEnrolled
        case noFingerprintEnrolled
        case biometricError
        case credentialsNotSaved

        var id: String {
            self.localizedDescription
        }

        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("Email/password incorrect", comment: "")
            case .deniedAccess:
                return NSLocalizedString("Permission for Face ID denied. Please enable it in your phone's settings.", comment: "")
            case .noFaceIdEnrolled:
                return NSLocalizedString("You do not have any Face IDs registered", comment: "")
            case .noFingerprintEnrolled:
                return NSLocalizedString("You do not have a fingerprint registered", comment: "")
            case .biometricError:
                return NSLocalizedString("Your face or fingerprint were not recognized", comment: "")
            case .credentialsNotSaved:
                return NSLocalizedString("Your Credentials have not been saved", comment: "")
            }
        }
    }

    func biometricType() -> BiometricType {
        let authContext = LAContext()
        let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)

        switch authContext.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touch
        case .faceID:
            return .face
        @unknown default:
            return .none
        }
    }

    func requestBiometricUnlock(
        email: String,
        completion: @escaping (Result<String, AuthenticationError>) -> Void
    ) {
        let password = KeychainManager().readUserPassword(email: email)
        guard password != nil else {
            completion(.failure(.credentialsNotSaved))
            return
        }

        let context = LAContext()
        var error: NSError?
        let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error {
            switch error.code {
            case -6: // Denied Access
                completion(.failure(.deniedAccess))
            case -7: // No biometrics enrolled
                if context.biometryType == .faceID {
                    completion(.failure(.noFaceIdEnrolled))
                } else {
                    completion(.failure(.noFingerprintEnrolled))
                }
            default:
                completion(.failure(.biometricError))
            }
            return
        }

        if canEvaluate {
            if context.biometryType != .none {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Need to access credentials") { success, error in
                    DispatchQueue.main.async {
                        if error != nil {
                            completion(.failure(.biometricError))
                        } else if let password {
                            completion(.success(password))
                        }
                    }
                }
            }
        }
    }
}
