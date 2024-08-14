import ComposableArchitecture
import Foundation

@Reducer
struct TabFeature {
    @ObservableState
    struct State: Equatable {
        var tabSelection: TabBarItem = .notice
        var noticeState = NoticeFeature.State(searchString: "")
        var complainState = ComplainFeature.State()
        var mealState = MealFeature.State(menu: [])
        var mypageState = MypageFeature.State()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case tabSelection(TabBarItem)
        case notice(NoticeFeature.Action)
        case complain(ComplainFeature.Action)
        case meal(MealFeature.Action)
        case mypage(MypageFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .tabSelection(tab):
                state.tabSelection = tab
                return .none
            case .binding:
                return .none
            case .notice, .complain, .meal, .mypage:
                return .none
            }
        }
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
    }
}
