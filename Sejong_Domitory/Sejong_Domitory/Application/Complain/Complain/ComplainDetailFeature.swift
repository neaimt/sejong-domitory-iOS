import Foundation
import ComposableArchitecture

@Reducer
struct ComplainDetailFeature {
    @ObservableState
    struct State: Equatable {
        let complain: Complaint
    }
    
    enum Action {
        case canceled
        case delegate(Delegate)
        enum Delegate {
            case confirmDeletion
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .canceled:
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
}
