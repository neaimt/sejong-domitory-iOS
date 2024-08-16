import Foundation
import ComposableArchitecture

@Reducer
struct NoticeFeature {
    @ObservableState
    struct State: Equatable {
        var notices: [Notice] = []
        var searchNotices: [Notice] {
            if searchString.isEmpty {
                return notices
            }
            else {
                return notices.filter{($0.detail.noticeTitle.contains(searchString))}
            }
        }
        
        var searchString: String
        var path = StackState<NoticeDetailFeature.State>()
    }
    
    enum Action {
        case setSearch(String)
        case path(StackAction<NoticeDetailFeature.State, NoticeDetailFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setSearch(title):
                state.searchString = title
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
            NoticeDetailFeature()
        }
    }
}
