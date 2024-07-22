//
//  Sejong_DomitoryApp.swift
//  Sejong_Domitory
//
//  Created by 박근경 on 2024/07/11.
//

import SwiftUI
import ComposableArchitecture

@main
struct Sejong_DomitoryApp: App {
    static let store = Store(initialState: LoginFeature.State()) {
      LoginFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView(store: Sejong_DomitoryApp.store)
        }
    }
}
