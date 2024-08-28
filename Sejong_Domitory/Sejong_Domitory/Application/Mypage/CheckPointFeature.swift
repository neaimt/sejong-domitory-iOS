import ComposableArchitecture

@Reducer
struct CheckPointFeature {
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action {
        case backButtonTapped
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .backButtonTapped:
                return .none
            }
        }
    }
}
