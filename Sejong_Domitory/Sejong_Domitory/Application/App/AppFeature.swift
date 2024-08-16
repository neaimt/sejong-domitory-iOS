import ComposableArchitecture

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var isLoggedIn = false
        var loginState: LoginFeature.State?
        var tabState: TabFeature.State?
    }
    
    enum Action {
        case firstView
        case login(LoginFeature.Action)
        case tab(TabFeature.Action)
        case setLoggedIn(Bool)
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case .firstView:
                if state.loginState == nil {
                    state.loginState = LoginFeature.State()
                }
                print("AppView OnAppear")
                return .none
            case .setLoggedIn(let isLoggedIn):
                state.isLoggedIn = isLoggedIn
                if isLoggedIn {
                    state.tabState = TabFeature.State()
                    state.loginState = nil
                } else {
                    state.loginState = LoginFeature.State()
                    state.tabState = nil
                }
                return .none
                
            case .login(.loginButtonTapped):
                print("App loginButtonTapped")
                return .send(.setLoggedIn(true))
            case .tab(.mypage(.logoutButtonTapped)):
                print("App logoutButtonTapped")
                return .send(.setLoggedIn(false))
            case .login, .tab:
                return .none
            }
        }
        .ifLet(\.loginState, action: /Action.login) {
                   LoginFeature()
        }
        .ifLet(\.tabState, action: /Action.tab) {
                   TabFeature()
        }
    }
}
