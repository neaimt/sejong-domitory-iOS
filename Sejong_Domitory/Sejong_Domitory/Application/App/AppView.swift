import ComposableArchitecture
import SwiftUI

struct AppView: View {
    @Bindable var store: StoreOf<AppFeature>
    
    var body: some View {
        VStack {
            if store.isLoggedIn {
                IfLetStore(store.scope(state: \.tabState, action: \.tab)) { store in
                    TabView(store: store)
                }
            } else {
                IfLetStore(store.scope(state: \.loginState, action: \.login)) { store in
                    LoginView(store: store)
                }
            }
        }
        .onAppear {
            print("AppView OnAppear")
            if !store.isLoggedIn {
                store.send(.setLoggedIn(false))
            }
        }

    }
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State(), reducer: {AppFeature()}))
}
