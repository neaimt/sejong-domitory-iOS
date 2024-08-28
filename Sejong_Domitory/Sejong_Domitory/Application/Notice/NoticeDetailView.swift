import SwiftUI
import ComposableArchitecture

struct NoticeDetailView: View {
    @Bindable var store: StoreOf<NoticeDetailFeature>
    
    var body: some View {
        VStack {
            Button(action: {
                store.send(.delegate(.disappear))
            }, label: {
                Text("뒤로가기버튼")
            })
            Text(store.notice.detail.noticeTitle)
            Text(store.notice.detail.noticeCreatedAt)
            Text(store.notice.detail.content)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            print("NoticeDetailView 나타남")
            store.send(.delegate(.appear))
        }
        .onDisappear {
            print("NoticeDetailView 사라짐")
        }
    }
}
