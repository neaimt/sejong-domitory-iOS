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
                state.selection = tab
                return .none
                
            case .binding(_):
                return .none
                
//            case .mypage(.logoutButtonTapped):
//                print("Tab logoutButtonTapped")
//                return .send(.logout
//                
//            case .logout:
//                return .none
                
            case .notice, .complain, .meal, .mypage:
                return .none
            }
        }
    }
}


//import ComposableArchitecture
//import Foundation
//
//@Reducer
//struct TabFeature {
//    @ObservableState
//    struct State: Equatable {
//        var tabSelection: TabBarItem = .notice
//        var noticeState = NoticeFeature.State(
//            notices: noticeList.notices,
//            searchString: ""
//        )
//        var complainState = ComplainFeature.State()
//        var mealState = MealFeature.State(menu: [])
//        var mypageState = MypageFeature.State()
//    }
//    
//    enum Action: BindableAction {
//        case binding(BindingAction<State>)
//        case tabSelection(TabBarItem)
//        case notice(NoticeFeature.Action)
//        case complain(ComplainFeature.Action)
//        case meal(MealFeature.Action)
//        case mypage(MypageFeature.Action)
//        
//        case logout
//    }
//    
//    var body: some ReducerOf<Self> {
//        BindingReducer()
//        
//        Reduce { state, action in
//            switch action {
//            case let .tabSelection(tab):
//                state.tabSelection = tab
//                return .none
//                
//            case .binding(_):
//                return .none
//                
//            case .mypage(.logoutButtonTapped):
//                print("Tab logoutButtonTapped")
//                return .none
//                
//            case .logout:
//                return .none
//                
//            case .notice, .complain, .meal, .mypage:
//                return .none
//            }
//        }
//        Scope(state: \.noticeState, action: /Action.notice) {
//            NoticeFeature()
//        }
//        Scope(state: \.complainState, action: /Action.complain) {
//            ComplainFeature()
//        }
//        Scope(state: \.mealState, action: /Action.meal) {
//            MealFeature()
//        }
//        Scope(state: \.mypageState, action: /Action.mypage) {
//            MypageFeature()
//        }
//    }
//}
