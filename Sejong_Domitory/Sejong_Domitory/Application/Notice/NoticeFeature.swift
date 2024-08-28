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
        
        case detailAppear
        case detailDisappear
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setSearch(title):
                state.searchString = title
                return .none
                
            case .path(.element(id: _, action: .delegate(.appear))):
                print("NoticeView에서 DetailView 생성 감지")
                return .send(.detailAppear)
                
            case .path(.element(id: _, action: .delegate(.disappear))):
                print("NoticeView에서 DetailView 소멸 감지")
                return .send(.detailDisappear)
                
            case .path(_), .detailAppear, .detailDisappear:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            NoticeDetailFeature()
        }
    }
}
