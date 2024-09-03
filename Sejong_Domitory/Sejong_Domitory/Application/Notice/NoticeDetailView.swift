import SwiftUI
import ComposableArchitecture

struct NoticeDetailView: View {
    @Bindable var store: StoreOf<NoticeDetailFeature>
    
    var body: some View {
        VStack {
            header
            Divider()
                .padding(.bottom, 10)
                
            if let notice = store.notice {
                Text(notice.noticeTitle) // 제목
                    .font(.system(size: 18, weight: .bold))
                
                Text(notice.noticeCreatedAt) // 날짜
                    .foregroundStyle(Color.sejonggray)
                    .font(.system(size: 12, weight: .bold))
                
                Divider()
                    .padding(.bottom, 10)
                
                Text(notice.noticeContent) // 내용
                    .font(.system(size: 14))
                ForEach(notice.attachedFiles) { content in
                    Text(content.attachedFileName) // 내용
                    Text(content.attachedFileUrl) // 내용
                }.font(.system(size: 14))
            }
             else {
                Text("글을 성공적으로 불러오지 못했습니다.")
            }

            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            print("NoticeDetailView 나타남")
            store.send(.onAppear)
            store.send(.delegate(.appear))
        }
        .onDisappear {
            print("NoticeDetailView 사라짐")
        }
        .overlay {
            if store.isLoading {
                ProgressView()
            }
        }
        .alert(store: store.scope(state: \.$alert, action: { .alert($0) }))
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

//#Preview {
//    NoticeDetailView(store: Store(initialState: NoticeDetailFeature.State(notice: noticeList.notices[1]), reducer: {NoticeDetailFeature()}))
//}
