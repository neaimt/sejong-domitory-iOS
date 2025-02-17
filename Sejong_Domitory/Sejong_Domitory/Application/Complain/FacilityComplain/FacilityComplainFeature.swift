import ComposableArchitecture

@Reducer
struct FacilityComplainFeature {
    @ObservableState
    struct State: Equatable {
        var complain: [Complaint]
        
        var path = StackState<ComplainDetailFeature.State>()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case path(StackAction<ComplainDetailFeature.State, ComplainDetailFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
                
            case .path(_):
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            ComplainDetailFeature()
        }
    }
}
