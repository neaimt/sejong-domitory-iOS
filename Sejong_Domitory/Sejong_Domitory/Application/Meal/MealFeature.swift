import ComposableArchitecture
import Foundation

@Reducer
struct MealFeature {
    @ObservableState
    struct State: Equatable {
        var day = ["월", "화", "수", "목", "금", "토", "일"]
        var menu: [Menu] // 날짜, 점심 - 저녁 식단
        var selectedDay: String? // 선택된 요일
        var mealBoardLoding: Bool = false // 식단표 api 호출 성공 여부
    }
    
    enum Action {
        case daySelected(String)
        case dayButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            
            case let .daySelected(day):
                state.selectedDay = day
                return .none
                
            case .dayButtonTapped:
                return .none
                
            }
        }
    }
}
