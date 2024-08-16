import ComposableArchitecture

@Reducer
struct MypageFeature {
    @ObservableState
    struct State: Equatable {
        var toggleisOn: Bool = false
    }
    
    enum Action : BindableAction {
        case binding(BindingAction<State>)
        case logoutButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
                
            case .logoutButtonTapped:
                print("mypage logoutButtonTapped")
                return .none
            }
        }
    }
}
