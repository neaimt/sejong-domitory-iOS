import SwiftUI
import ComposableArchitecture

struct TabView: View {
    @Bindable var store: StoreOf<TabFeature>
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ForEach(store.tabs, id: \.self) { tab in
                VStack {
                    if store.selection == tab {
                        // 각 탭에 해당하는 화면을 여기에 추가
                        if store.selection == .notice {
                            NoticeView(store: store.scope(state: \.noticeState, action: \.notice))
                        }
                        else if store.selection == .complain {
                            ComplainView()
                        }
                        else if store.selection == .meal {
                            NavigationView {
                                MealView(store: store.scope(state: \.mealState, action: \.meal))
                            }
                        }
                        else if store.selection == .mypage {
                            MypageView(store: store.scope(state: \.mypageState, action: \.mypage))
                        }
                    }
                }
            }
            
            tabBarVersion1(Store: store)
                .onChange(of: store.selection, { oldValue, newValue in
                    store.send(.switchToTab(newValue))
                })
        }
        .ignoresSafeArea()
    }
    
    
    private func tabView(tab: TabBarItem, Store: Store<TabFeature.State, TabFeature.Action>) -> some View {
        VStack {
            if(Store.selection == tab) {
                Image("selected" + tab.iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            } else {
                Image(tab.iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }
            
            Text(tab.title)
                .font(.system(size: 10, weight: .bold))
        }
        .foregroundColor(Store.selection == tab ? Color.crimsonred : Color.sejonggray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
    }
    
    private func tabBarVersion1(Store: Store<TabFeature.State, TabFeature.Action>) -> some View {
        HStack {
            ForEach(Store.tabs, id: \.self) { tab in
                tabView(tab: tab, Store: Store)
                    .onTapGesture {
                        Store.send(.switchToTab(tab))
                    }
            }
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .background(Color.white)
        .frame(maxWidth: .infinity)
        .clipShape(
            .rect(
                topLeadingRadius: 10,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 10
            )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 0.1)
        )
    }
                                  
    
}

#Preview {
    TabView(store: Store(initialState: TabFeature.State(),
                         reducer: {TabFeature()}))
}




//import SwiftUI
//import ComposableArchitecture
//
//struct TabView: View {
//    @Bindable var store: StoreOf<TabFeature>
//
//    var body: some View {
//        NavigationStack {
//            Button("로그아웃 버튼") {
//                store.send(.logout)
//            }
//            CustomTabBarContainerView(selection: $store.tabSelection) {
//                NoticeView(
//                    store: Store(
//                        initialState: store.noticeState,
//                        reducer: {
//                            NoticeFeature()
//                }))
//                .tabBarItem(tab: .notice, selection: $store.tabSelection)
//
//                ComplainView()
//                .tabBarItem(tab: .complain, selection: $store.tabSelection)
//
//                NavigationView {
//                    MealView(store: Store(initialState: store.mealState, reducer: {
//                        MealFeature()
//                    }))
//                }
//                .tabBarItem(tab: .meal, selection: $store.tabSelection)
//
//                MypageView(
//                    store: Store(
//                        initialState: store.mypageState,
//                        reducer: { MypageFeature()
//                }))
//                .tabBarItem(tab: .mypage, selection: $store.tabSelection)
//            }
//            .ignoresSafeArea()
//        }
//    }
//}
//
