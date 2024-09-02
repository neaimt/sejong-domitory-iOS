import SwiftUI
import ComposableArchitecture

struct NoticeDetailView: View {
    @Bindable var store: StoreOf<NoticeDetailFeature>
    
    var body: some View {
        VStack {
            header
            Divider()
                .padding(.bottom, 10)
            
           
            
                Text(store.notice.detail.noticeTitle) // 제목
                    .font(.system(size: 18, weight: .bold))
                
                Text(store.notice.detail.noticeCreatedAt) // 날짜
                    .foregroundStyle(Color.sejonggray)
                    .font(.system(size: 12, weight: .bold))
            
            
            Divider()
                .padding(.bottom, 10)
            
            Text(store.notice.detail.content) // 내용
                .font(.system(size: 14))
            
            Spacer()
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
    
    // 상단바
    private var header: some View {
        HStack {
            Button {
                store.send(.delegate(.disappear))
            } label: {
                Image(systemName: "lessthan")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 13, height: 22)
                    .foregroundStyle(Color.black)
                    .padding(.leading, 16)
            }
            
            Spacer()
        }
    }
}

#Preview {
    NoticeDetailView(store: Store(initialState: NoticeDetailFeature.State(notice: noticeList.notices[1]), reducer: {NoticeDetailFeature()}))
}
