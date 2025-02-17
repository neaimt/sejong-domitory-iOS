import ComposableArchitecture
import SwiftUI

@Reducer
struct TabFeature {
    @ObservableState
    struct State: Equatable {
        var selection: TabBarItem = .notice
        var localSelection: TabBarItem = .notice
        var tabs: [TabBarItem] = [.notice, .complain, .meal, .mypage]
        
        var tabIsShow: Bool = true
        
        var noticeState: NoticeFeature.State = NoticeFeature.State(searchString: "")
        var complainState: ComplainFeature.State = ComplainFeature.State()
        var mealState = MealFeature.State()
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
            
            case .notice(.detailAppear):
                print("TabView에서 DetailView 생성 감지")
                state.tabIsShow = false
                return .none
                
            case .notice(.detailDisappear):
                print("TabView에서 DetailView 소멸 감지")
                state.tabIsShow = true
                return .none
                
            case .complain(.backButtonTapped):
                return .send(.switchToTab(.notice))
                
            case .notice, .complain, .meal, .mypage:
                return .none
            }
        }
    }
}

