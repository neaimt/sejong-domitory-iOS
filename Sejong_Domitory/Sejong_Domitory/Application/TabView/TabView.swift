//
//  TabView.swift
//  Sejong_Domitory
//
//  Created by 박근경 on 2024/07/22.
//

import SwiftUI

struct TabView: View {
    @State private var tabSelection: TabBarItem = .notice
    
    var body: some View {
        NavigationStack {
            CustomTabBarContainerView(selection: $tabSelection) {
                NoticeView()
                    .tabBarItem(tab: .notice, selection: $tabSelection)
                
                ComplainView()
                    .tabBarItem(tab: .complain, selection: $tabSelection)
                MypageView()
                    .tabBarItem(tab: .meal, selection: $tabSelection)
                MypageView()
                    .tabBarItem(tab: .mypage, selection: $tabSelection)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    TabView()
}
