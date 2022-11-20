//
// UserPreferencesManager.swift
// OpusAeries
//

import SwiftUI

class UserPreferencesManager: ObservableObject {
    @AppStorage("automaticallyUseFaceId") var automaticallyUseFaceId: Bool = true
}
