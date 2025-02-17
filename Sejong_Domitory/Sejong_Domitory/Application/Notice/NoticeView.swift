import SwiftUI
import ComposableArchitecture

struct NoticeView: View {
    @Bindable var store: StoreOf<NoticeFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack(alignment: .leading) {
                
                title // 공지사항 글씨
                searchBar // 검색바
                
                // 리스트 스크롤 뷰로 제작
                ScrollView {
                    ForEach(store.notices, id: \.self) { content in
                        NavigationLink(state: NoticeDetailFeature.State(noticeId: content.noticeId)) {
                            notice(content: content)
                        }
                    }
                }
                .padding(.top, 10)
                
                Spacer()
                
            }
            .ignoresSafeArea()
        } destination: { store in
            NoticeDetailView(store: store)
        }
        .onAppear {
            print("NoticeView 나타남")
            store.send(.onAppear)
          
        }
        .overlay {
            if store.isLoading {
                ProgressView()
            }
        }
        .alert(
            store: store.scope(
                state: \.$alert,
                action: \.alert
            )
        )
    }
    
    // 공지사항
    private var title: some View {
        Text("공지사항")
            .font(.system(size: 20, weight: .bold))
            .padding(.leading, 25)
            .padding(.bottom, 20)
            .padding(.top, 60)
    }
    
    // 검색바
    private var searchBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.search)
                .frame(height: 35)
            
            HStack {
                Image("search")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                TextField("검색", text: $store.searchString.sending(\.setSearch))
                    .foregroundColor(Color.sejonggray)
            }
            .padding(.leading, 10)
        }
        .padding(.horizontal, 25)
    }
    
    // 공지리스트 -> 네비게이션 링크 설정 필요
    @ViewBuilder func notice(content : Notice) -> some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 70)
                    
                
                VStack(alignment: .leading) {
                    Text(content.noticeWriter + " / " + content.noticeCreatedAt )
                        .font(.system(size: 10, weight: .bold))
                        .padding(.bottom, 10)
                    
                    Text(content.noticeTitle)
                        .font(.system(size: 14, weight: .bold))
                        .padding(.bottom, 10)
                }
                .foregroundStyle(Color.black)
                .padding(.leading, 10)
            }
            
            Divider()
                .foregroundStyle(Color.search)
                .offset(y:-7)
        }
    }
}

#Preview {
    NoticeView(
        store: Store(
            initialState: NoticeFeature.State(
                notices: [],
                searchString: ""
            ),
            reducer: {
                NoticeFeature()
            }
        )
    )
}
