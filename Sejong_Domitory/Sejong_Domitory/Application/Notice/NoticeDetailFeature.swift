import Foundation
import ComposableArchitecture

@Reducer
struct NoticeDetailFeature {
    @ObservableState
    struct State: Equatable {
        let notice: Notice
    }
    
    enum Action {
        case delegate(Delegate)
        enum Delegate {
            case appear
            case disappear
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .delegate(.disappear):
                return .run { _ in
                    await self.dismiss()
                }
            case .delegate:
                return .none
            }
        }
    }
}
