//
// UserPreferencesManager.swift
// OpusAeries
//

import SwiftUI

class UserPreferencesManager: ObservableObject {
    @AppStorage("automaticallyUseFaceId") var automaticallyUseFaceId: Bool = true
    
    @AppStorage("displayPop") var displayPop: Bool = true
}
