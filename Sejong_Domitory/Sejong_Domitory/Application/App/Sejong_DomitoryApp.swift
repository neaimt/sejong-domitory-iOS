import SwiftUI
import ComposableArchitecture

@main
struct Sejong_DomitoryApp: App {
    static let store = Store(initialState: AppFeature.State()) {
      AppFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: Sejong_DomitoryApp.store) 
        }
    }
}
