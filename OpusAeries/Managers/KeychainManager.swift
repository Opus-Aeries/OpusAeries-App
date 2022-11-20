//
// KeychainManager.swift
// OpusAeries
//

import Foundation

/// Contains functions for accessing Apple Keychain
class KeychainManager {

    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }

    func saveUserPassword(email: String, password: String) {
        do {
            try KeychainManager.saveData(
                service: "aeries.net",
                account: email,
                password: password.data(using: .utf8) ?? Data()
            )
        } catch {
            print(error)
        }
    }

    func readUserPassword(email: String) -> String? {
        do {
            guard let data = try KeychainManager.readData(
                service: "aeries.net",
                account: email
            ) else {
                print("Failed to read data")
                return nil
            }

            let password = String(decoding: data, as: UTF8.self)
            return password

        } catch {
            print(error)
            return nil
        }
    }

    /// Generic function to save data to keychain
    /// - Parameters:
    ///   - service: The specific service to save data for
    ///   - account: The account/username/email to save data for
    ///   - password: The password to save
    static func saveData(
        service: String,
        account: String,
        password: Data
    ) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: password as AnyObject,
        ]

        let status = SecItemAdd(
            query as CFDictionary,
            nil
        )

        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateEntry
        }

        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }

        print("Saved Data to Keychain")
    }

    /// Generic function to read data from keychain
    /// - Parameters:
    ///   - service: The service of the requested item
    ///   - account: The account of the requested item
    /// - Returns: Data representing password
    static func readData(
        service: String,
        account: String
    ) throws -> Data? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)



        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }

        print("Read status: \(status)")

        return result as? Data
    }
}
