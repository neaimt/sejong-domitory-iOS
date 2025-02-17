import ComposableArchitecture

@Reducer
struct ComplainFeature {
    @ObservableState
    struct State: Equatable {
        var search: String = ""
        var isShow: Bool = false
        var title: String = "시설민원"
        
        var facilityState: FacilityComplainFeature.State = FacilityComplainFeature.State(complain: facilitys.complaints)
        var lifeState: LifeComplainFeature.State = LifeComplainFeature.State(complain: lifes.complaints)
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case typeButtonTapped(String)
        case facilityButtonTapped
        case lifeButtonTapped
        case showDialog(Bool)
        
        case backButtonTapped
        
        case facilityAction(FacilityComplainFeature.Action)
        case lifeAction(LifeComplainFeature.Action)
        
        case updatePath
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.facilityState, action: /Action.facilityAction) {
            FacilityComplainFeature()
        }
        Scope(state: \.lifeState, action: /Action.lifeAction) {
            LifeComplainFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
                
            case .showDialog(let show):
                state.isShow = show
                return .none
                
            case .typeButtonTapped(let title):
                state.isShow = false
                return .run { send in
                    if ( title == "시설민원" ) {
                        await send(.facilityButtonTapped)
                    }
                    else {
                        await send(.lifeButtonTapped)
                    }
                }
                
            case .facilityButtonTapped:
                state.title = "시설민원"
                return .run { send in
                    try await Task.sleep(for: .milliseconds(1))
                    await send(.updatePath)
                }
                
            case .lifeButtonTapped:
                state.title = "생활민원"
                return .run { send in
                    try await Task.sleep(for: .milliseconds(1))
                    await send(.updatePath)
                }
                
            case .updatePath:
                if state.title == "시설민원" {
                    state.facilityState.path = StackState<ComplainDetailFeature.State>()
                } else {
                    state.lifeState.path = StackState<ComplainDetailFeature.State>()
                }
                return .none
                
            case .backButtonTapped:
                return .none
                
            case .facilityAction(_):
                return .none
                
            case .lifeAction(_):
                return .none
            }
        }
    }
}
