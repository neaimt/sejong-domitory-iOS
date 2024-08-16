//import SwiftUI
//
//struct CustomTabBarView: View {
//    let tabs: [TabBarItem]
//    
//    @Namespace private var namespace
//    @State var localSelection: TabBarItem
//    @Binding var selection: TabBarItem
//    
//    var body: some View {
//        tabBarVersion1
//            .onChange(of: selection, { oldValue, newValue in
//                localSelection = newValue
//            })
//    }
//}
//
//extension CustomTabBarView {
//    // 탭바 아이템 한개의 뷰
//    
//    private func tabView(tab: TabBarItem) -> some View {
//        VStack {
//            if(localSelection == tab) {
//                Image("selected" + tab.iconName)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 30, height: 30)
//            }
//            else {
//                Image(tab.iconName)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 30, height: 30)
//            }
//            
//            Text(tab.title)
//                .font(.system(size: 10, weight: .bold))
//        }
//        .foregroundColor(localSelection == tab ? Color.crimsonred : Color.sejonggray)
//        .padding(.vertical, 8)
//        .frame(maxWidth: .infinity)
//    }
//    
//    private func switchToTab(tab: TabBarItem) {
//        selection = tab
//    }
//    
//    private var tabBarVersion1: some View {
//        HStack {
//            ForEach(tabs, id:\.self) { tab in
//                tabView(tab: tab)
//                    .onTapGesture {
//                        switchToTab(tab: tab)
//                    }
//                
//            }
//        }
//        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
//        .background(Color.white)
//        .frame(maxWidth: .infinity)
//        .clipShape(
//            .rect(
//                topLeadingRadius: 10,
//                bottomLeadingRadius: 0,
//                bottomTrailingRadius: 0,
//                topTrailingRadius: 10
//            )
//        )
//        .overlay(
//            RoundedRectangle(cornerRadius: 20)
//                .stroke(.black, lineWidth: 0.1)
//        )
//        
//    }
//}
