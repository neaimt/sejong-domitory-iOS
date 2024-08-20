import ComposableArchitecture
import Foundation

@Reducer
struct MealFeature {
    @ObservableState
    struct State: Equatable, Hashable {
        var day: [MealDay] = [MealDay(dayName: "월"),
                              MealDay(dayName: "화"),
                              MealDay(dayName: "수"),
                              MealDay(dayName: "목"),
                              MealDay(dayName: "금"),
                              MealDay(dayName: "토"),
                              MealDay(dayName: "일")]
        
        var menu: [Menu] // 날짜, 점심 - 저녁 식단
        var selectedDay: MealDay? // 선택된 요일
        var mealBoardLoding: Bool = false // 식단표 api 호출 성공 여부
        
        
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case daySelected(MealDay)
        case setInitialSelection
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case let .daySelected(day):
                state.selectedDay = day
                return .none
                
            case .setInitialSelection:
                state.selectedDay = state.day[0]
                return .none
                
            case .binding(_):
                return .none
            }
            
        }
    }
}
