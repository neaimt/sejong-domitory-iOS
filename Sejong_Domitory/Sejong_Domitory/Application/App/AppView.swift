import ComposableArchitecture
import SwiftUI

struct AppView: View {
    @Bindable var store: StoreOf<AppFeature>
    
    var body: some View {
        NavigationStack {
            if store.isLoggedIn {
                if let tabState = store.scope(state: \.tabState, action: \.tab) {
                    TabView(store: tabState)
                }
            } else {
                if let loginState = store.scope(state: \.loginState, action: \.login) {
                    LoginView(store: loginState)
                }
            }
        }
        .onAppear {
            store.send(.firstView)
        }
    }
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State(), reducer: {AppFeature()}))
}
