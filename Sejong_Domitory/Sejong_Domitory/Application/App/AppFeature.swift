import ComposableArchitecture

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var isLoggedIn = false
        var tabState: TabFeature.State?
        var loginState: LoginFeature.State?
    }
    
    enum Action {
        case login(LoginFeature.Action)
        case tab(TabFeature.Action)
        case setLoggedIn(Bool)
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
                
            case .setLoggedIn(let isLoggedIn): // 로그인 유무에 따라 로그인 화면, 탭 화면 변경
                state.isLoggedIn = isLoggedIn
                
                if isLoggedIn {
                    state.tabState = TabFeature.State()
                    state.loginState = nil
                } else {
                    state.loginState = LoginFeature.State()
                    if state.tabState != nil {
                        state.tabState = nil
                    }
                }
                return .none
                
            case .login(.loginResponse(.success)): // 로그인 화면에서 로그인 버튼 클릭
                print("App loginButtonTapped")
                return .send(.setLoggedIn(true))
                
            case .tab(.mypage(.logoutButtonTapped)): // 마이페이지 화면에서 로그아웃 버튼 클릭
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
