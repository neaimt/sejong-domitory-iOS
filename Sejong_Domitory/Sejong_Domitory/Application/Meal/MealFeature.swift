import ComposableArchitecture
import Foundation

@Reducer
struct MealFeature {
    @ObservableState
    struct State: Equatable {
        var day: [MealDay] = [MealDay(dayName: "월"),
                              MealDay(dayName: "화"),
                              MealDay(dayName: "수"),
                              MealDay(dayName: "목"),
                              MealDay(dayName: "금"),
                              MealDay(dayName: "토"),
                              MealDay(dayName: "일")]
        
//        var menu: [Menu] = [// 날짜, 점심 - 저녁 식단
//            Menu(menuId: 1, date: "2024년 8월 5일", lunch: "쌀밥 맑은미역국 돈육김치찜 사천식가지볶음 마카로니샐러드 배추김치", dinner: "쌀밥 팽이장국 콩나물불고기 허니버터웨지감자 양념깻잎지 배추김치"),
//            Menu(menuId: 2, date: "2024년 8월 6일", lunch: "쌀밥 부대찌개 꼬마돈가스/케찹 찰떡가마보꼬 꼬시래기초무침 배추김치", dinner: "쌀밥 콩나물냉국 언양식불고기/파채 핫도그/케찹 무짠지무침 배추김치"),
//            Menu(menuId: 3, date: "2024년 8월 7일", lunch: "쌀밥 맑은미역국 돈육김치찜 사천식가지볶음 마카로니샐러드 배추김치", dinner: "쌀밥 팽이장국 콩나물불고기 허니버터웨지감자 양념깻잎지 배추김치"),
//            Menu(menuId: 4, date: "2024년 8월 8일", lunch: "쌀밥 맑은미역국 돈육김치찜 사천식가지볶음 마카로니샐러드 배추김치", dinner: "쌀밥 팽이장국 콩나물불고기 허니버터웨지감자 양념깻잎지 배추김치"),
//            Menu(menuId: 5, date: "2024년 8월 9일", lunch: "쌀밥 맑은미역국 돈육김치찜 사천식가지볶음 마카로니샐러드 배추김치", dinner: "쌀밥 팽이장국 콩나물불고기 허니버터웨지감자 양념깻잎지 배추김치") ,
//            Menu(menuId: 6, date: "2024년 8월 10일", lunch: "쌀밥 맑은미역국 돈육김치찜 사천식가지볶음 마카로니샐러드 배추김치", dinner: "쌀밥 팽이장국 콩나물불고기 허니버터웨지감자 양념깻잎지 배추김치"),
//            Menu(menuId: 7, date: "2024년 8월 11일", lunch: "쌀밥 맑은미역국 돈육김치찜 사천식가지볶음 마카로니샐러드 배추김치", dinner: "쌀밥 팽이장국 콩나물불고기 허니버터웨지감자 양념깻잎지 배추김치")
//        ]
        
        var menus: IdentifiedArrayOf<Menu> = []
        var isLoading = false
        @Presents var alert: AlertState<Action.Alert>?
        
        
        
        var selectedDay: MealDay? // 선택된 요일
        var mealBoardLoding: Bool = false // 식단표 api 호출 성공 여부
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case daySelected(MealDay)
        case setInitialSelection
        
        case onAppear
        case fetchMenus
        case fetchMenusResponse(TaskResult<[Menu]>)
        case alert(PresentationAction<Alert>)
        
        enum Alert: Equatable {}
    }
    
    @Dependency(\.menuClient) var menuClient
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
                
            case .onAppear:
                if state.menus.isEmpty && !state.isLoading {
                    return .send(.fetchMenus)
                }
                return .none
                
            case .fetchMenus:
                state.isLoading = true
                return .run { send in
                    await send(.fetchMenusResponse(TaskResult { try await menuClient.fetch() }))
                }
                
            case let .fetchMenusResponse(.success(menus)):
                state.isLoading = false
                state.menus = IdentifiedArray(uniqueElements: menus)
                return .none
                
            case let .fetchMenusResponse(.failure(error)):
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
