import ComposableArchitecture

@Reducer
struct LifeComplainFeature {
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
                
            case let .path(.element(id: id, action: .delegate(.confirmDeletion))):
                guard state.path[id: id] != nil
                    else { return .none }
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
