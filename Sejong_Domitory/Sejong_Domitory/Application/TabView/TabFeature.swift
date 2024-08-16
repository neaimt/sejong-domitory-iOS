import ComposableArchitecture
import SwiftUI

@Reducer
struct TabFeature {
    @ObservableState
    struct State: Equatable {
        var selection: TabBarItem = .notice
        var localSelection: TabBarItem = .notice
        var tabs: [TabBarItem] = [.notice, .complain, .meal, .mypage]
        
        
        var noticeState = NoticeFeature.State(
            notices: noticeList.notices,
            searchString: ""
        )
        var complainState = ComplainFeature.State()
        var mealState = MealFeature.State(menu: [])
        var mypageState = MypageFeature.State()
        
    }
    
    enum Action: BindableAction {
        case switchToTab(TabBarItem)
        case binding(BindingAction<State>)
        
        case notice(NoticeFeature.Action)
        case complain(ComplainFeature.Action)
        case meal(MealFeature.Action)
        case mypage(MypageFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.noticeState, action: /Action.notice) {
            NoticeFeature()
        }
        Scope(state: \.complainState, action: /Action.complain) {
            ComplainFeature()
        }
        Scope(state: \.mealState, action: /Action.meal) {
            MealFeature()
        }
        Scope(state: \.mypageState, action: /Action.mypage) {
            MypageFeature()
        }
        
        Reduce { state, action in
            switch action {
            case let .switchToTab(tab):
                if state.selection != tab {
                    state.selection = tab
                }
                return .none
                
            case .binding(_):
                return .none
            
            case .notice, .complain, .meal, .mypage:
                return .none
            }
        }
    }
}

