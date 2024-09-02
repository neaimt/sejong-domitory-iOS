import Foundation
import ComposableArchitecture

@Reducer
struct ComplainDetailFeature {
    @ObservableState
    struct State: Equatable {
        let complain: Complaint
    }
    
    enum Action {
        case backButtonTapped
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backButtonTapped:
                return .run { _ in
                    await self.dismiss()
                }
            }
        }
    }
}
