import SwiftUI
import ComposableArchitecture

struct NoticeDetailView: View {
    @Bindable var store: StoreOf<NoticeDetailFeature>
    
    var body: some View {
        VStack {
            Text(store.notice.detail.noticeTitle)
            Text(store.notice.detail.noticeCreatedAt)
            Text(store.notice.detail.content)
        }
    }
}
