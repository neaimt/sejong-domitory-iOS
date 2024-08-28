import ComposableArchitecture
import Foundation

@Reducer
struct MypageFeature {
    @ObservableState
    struct State: Equatable {
        var toggleIsOn: Bool = false
        
        var openURL: URL?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case toggleButtonTapped(Bool)
        case logoutButtonTapped
        
        case openURL(URL)
    }
    
    var body: some ReducerOf<Self> {
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
                
            case let .openURL(url):
                state.openURL = url
                return .none
            }
        }
    }
}
