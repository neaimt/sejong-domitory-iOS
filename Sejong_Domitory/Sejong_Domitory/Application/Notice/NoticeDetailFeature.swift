import Foundation
import ComposableArchitecture

@Reducer
struct NoticeDetailFeature {
    @ObservableState
    struct State: Equatable {
        let noticeId: Int
        
        var notice: NoticeDetail?
        
        var isLoading = false
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    enum Action {
        case delegate(Delegate)
        enum Delegate {
            case appear
            case disappear
        }
        
        case onAppear
        case fetchNoticeDetail(URL)
        case fetchNoticeDetailResponse(TaskResult<NoticeDetail>)
        case alert(PresentationAction<Alert>)
        
        enum Alert: Equatable {}
    }
    
    
    @Dependency(\.noticeDetailClient) var noticeDetailClient
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
                
            case .onAppear:
                if let url = URL(string: "\(serverURL)/\(state.noticeId)") {
                    if state.notice == nil && !state.isLoading {
                        print("Valid URL: \(url)")
                        return .send(.fetchNoticeDetail(url))
                    }
                } else {
                    print("Invalid URL")
                }
                return .none

            case .fetchNoticeDetail(let url):
                state.isLoading = true
                return .run { send in
                    print("\(url)")
                    await send(.fetchNoticeDetailResponse(TaskResult { try await noticeDetailClient.fetch(url) }))
                }
                
            case let .fetchNoticeDetailResponse(.success(notice)):
                state.isLoading = false
                state.notice = notice
                return .none
                
            case let .fetchNoticeDetailResponse(.failure(error)):
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
                
            case .alert:
                return .none
            }
        }
        .ifLet(\.$alert, action: /Action.alert)
    }
}
