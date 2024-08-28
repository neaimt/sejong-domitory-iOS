import ComposableArchitecture
import Foundation

@Reducer
struct MypageFeature {
    @ObservableState
    struct State: Equatable {
        var toggleIsOn: Bool = false
        
        var openURL: URL?
        
        var pointViewIsShow: Bool = false
        var pointState: CheckPointFeature.State = CheckPointFeature.State()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case toggleButtonTapped(Bool)
        case logoutButtonTapped
        case pointButtonTapped
        
        case openURL(URL)
        case pointAction(CheckPointFeature.Action)
        
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.pointState, action: /Action.pointAction) {
            CheckPointFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            
            case .logoutButtonTapped:
                print("mypage logoutButtonTapped")
                return .none
                
            case .toggleButtonTapped(_):
                state.toggleIsOn.toggle()
                return .none
                
            case .pointButtonTapped:
                state.pointViewIsShow = true
                return .none
                
            case let .openURL(url):
                state.openURL = url
                return .none
                
            case .pointAction(.backButtonTapped):
                state.pointViewIsShow = false
                return .none
            }
        }
    }
}
