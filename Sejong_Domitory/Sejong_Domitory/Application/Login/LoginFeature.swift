import ComposableArchitecture


@Reducer
struct LoginFeature {
    // 텍스트 필드 오류 찾기
    @ObservableState
    struct State: Equatable {
        var userId: String = ""
        var password: String = ""
        
        var isLoading = false
        var loginRecord: LoginRecord?
        @Presents var alert: AlertState<Action.Alert>?
        
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case updateUserId(String)
        case updatePassword(String)
        case loginButtonTapped
        case loginResponse(TaskResult<LoginRecord>)
        case alert(PresentationAction<Alert>)
        
        enum Alert: Equatable {}
    }
    
    @Dependency(\.authClient) var authClient
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            
            case let .updateUserId(userId):
                state.userId = userId
                return .none
                
            case let .updatePassword(password):
                state.password = password
                return .none
                
            case .loginButtonTapped:
                print("\(state.userId) \(state.password)")
                state.isLoading = true
                let user = User(userId: state.userId, password: state.password)
                return .run { send in
                    await send(.loginResponse(TaskResult { try await authClient.login(user) }))
                }
                
            case let .loginResponse(.success(loginRecord)):
                state.isLoading = false
                state.loginRecord = loginRecord
                return .none
                
            case let .loginResponse(.failure(error)):
                print("에러 원인: \(error.localizedDescription)")
                state.isLoading = false
                state.alert = AlertState {
                    TextState("아이디 또는 비밀번호가 일치하지 않습니다.")
                } actions: {
                    ButtonState(role: .cancel) {
                        TextState("확인")
                    }
                } 
                return .none
                
            case .alert:
                return .none
            }
        }
        .ifLet(\.$alert, action: /Action.alert)
    }
}
