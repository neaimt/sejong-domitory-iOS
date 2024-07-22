import ComposableArchitecture


@Reducer
struct LoginFeature {
    
    // 텍스트 필드 오류 찾기
    @ObservableState
    struct State: Equatable {
        var id: String = ""
        var pw: String = ""
        
        var idTyping: Bool {
            return id.count > 0 && id.count < 15
        }
        var pwTyping: Bool {
            return pw.count > 0 && pw.count < 15
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case loginButtonTapped
        case loginSuccess
        case loginFailure
    }
    
    // MARK: Reducer
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding(\.id):
                print ( "username" , state.id)
                return .none
            case .binding(\.pw):
                print ( "username" , state.pw)
                return .none
                
            case .loginSuccess:
                return .none
                
            case .loginFailure:
                return .none
                
            case .loginButtonTapped:
                if state.idTyping == true && state.pwTyping == true {
                    return .none
                }
                return .none
            case .binding(_):
                return .none
            }
        }
    }
}
