import ComposableArchitecture

@Reducer
struct MypageFeature {
    @ObservableState
    struct State: Equatable {
        var toggleIsOn: Bool = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case toggleButtonTapped(Bool)
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
                
            case let .toggleButtonTapped(isOn):
                state.toggleIsOn.toggle()
                return .none
            }
        }
    }
}
