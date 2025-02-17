import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
struct NoticeFeature {
    @ObservableState
    struct State: Equatable {
        var notices: IdentifiedArrayOf<Notice> = []
        
        var searchNotices: IdentifiedArrayOf<Notice> {
            if searchString.isEmpty {
                return notices
            }
            else {
                return notices.filter{($0.noticeTitle.contains(searchString))}
            }
        }
        
        var searchString: String
        var path = StackState<NoticeDetailFeature.State>()
        
        var isLoading = false
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    enum Action {
        case setSearch(String)
        case path(StackAction<NoticeDetailFeature.State, NoticeDetailFeature.Action>)
        
        case detailAppear
        case detailDisappear
        
        case onAppear
        case fetchNotices
        case fetchNoticesResponse(TaskResult<[Notice]>)
        case alert(PresentationAction<Alert>)
        
        enum Alert: Equatable {}
    }
    
    @Dependency(\.noticeClient) var noticeClient
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
                
            case .onAppear:
                if state.notices.isEmpty && !state.isLoading {
                    return .send(.fetchNotices)
                }
                return .none
                
            case .fetchNotices:
                state.isLoading = true
                return .run { send in
                    await send(.fetchNoticesResponse(TaskResult { try await noticeClient.fetch() }))
                }
                
            case let .fetchNoticesResponse(.success(notices)):
                state.isLoading = false
                state.notices = IdentifiedArrayOf(uniqueElements: notices)
                return .none
                
            case let .fetchNoticesResponse(.failure(error)):
                state.isLoading = false
                state.alert = AlertState {
                    TextState("Error")
                } actions: {
                    ButtonState(role: .cancel) {
                        TextState("OK")
                    }
                } message: {
                    TextState(error.localizedDescription)
                }
                return .none
                
            case .fetchNoticesResponse:
                return .none
            case .alert:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            NoticeDetailFeature()
        }
        .ifLet(\.$alert, action: /Action.alert) {
            
        }
    }
}
