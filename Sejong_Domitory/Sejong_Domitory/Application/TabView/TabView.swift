import SwiftUI
import ComposableArchitecture

struct TabView: View {
    @Bindable var store: StoreOf<TabFeature>
    
    var body: some View {
        NavigationStack {
            CustomTabBarContainerView(selection: $store.tabSelection) {
                NavigationView {
                    NoticeView(
                        store: Store(
                            initialState: NoticeFeature.State(
                                notices: noticeList.notices,
                                searchString: ""
                            ),
                            reducer: {
                                NoticeFeature()
                            }))
                }
                    .tabBarItem(tab: .notice, selection: $store.tabSelection)
                
                NavigationView {
                    ComplainView()
                }
                .tabBarItem(tab: .complain, selection: $store.tabSelection)
                    
                
                NavigationView {
                    MealView(store: Store(initialState: MealFeature.State(menu: []), reducer: {
                        MealFeature()
                    }))
                }
                    .tabBarItem(tab: .meal, selection: $store.tabSelection)
                
                NavigationView {
                    MypageView()
                }
                    .tabBarItem(tab: .mypage, selection: $store.tabSelection)
                    
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    TabView(store: Store(initialState: TabFeature.State(), 
                         reducer: {
        TabFeature()
    }))
}

