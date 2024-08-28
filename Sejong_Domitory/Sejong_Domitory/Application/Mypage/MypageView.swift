import SwiftUI
import ComposableArchitecture

struct MypageView: View {
    @Bindable var store: StoreOf<MypageFeature>
    
    var body: some View {
        VStack {
            header // 상단 마이페이지 바
            Spacer()
                .frame(height: 10)
                
            profile // 프로필
        
            homepage // 홈페이지 바로가기 버튼
            
            checkpoint // 상벌점 조회버튼
            
            alaram // 알림 버튼
        
            logoutButton // 로그아웃
            
            inquiry // 문의
            
            Spacer()
        }
        .fullScreenCover(isPresented: $store.pointViewIsShow, content: {
            CheckPointView(store: store.scope(state: \.pointState, action: \.pointAction))
        })
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .ignoresSafeArea()
    
    }
    
    // 상단바
    private var header: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Rectangle()
                .fill(Color.white)
                .frame(height: 100)
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 10,
                        bottomTrailingRadius: 10,
                        topTrailingRadius: 0)
                )
                .shadow(color: Color.sejonggray, radius: 1)
            
            Text("마이페이지")
                .font(.system(size: 18, weight: .bold))
                .padding(.bottom, 10)
        }
    }
    
    // 프로필
    private var profile: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .stroke(Color.crimsonred)
                    .frame(width: 150, height: 150)
                    .shadow(radius: 2)
                
                Text("🥳")
                    .font(.system(size: 80))
            }
            .padding(.top, 30)
            
            // 사용자 이름
            Text("김은지")
                .font(.system(size: 20, weight: .bold))
        }
    }
    
    // 기숙사 홈페이지 바로가기 버튼
    private var homepage: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            Button {
                store.send(.openURL(URL(string: "http://sejong.ac.kr/")!))
                UIApplication.shared.open(store.openURL!)
            } label: {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 50)
            }
            
//            Link(destination: URL(string: "http://sejong.ac.kr/" )!) {
//                        Text("Safari App으로 이동해서 보여주기")
//                    }
            Text("기숙사 홈페이지 바로가기")
                .font(.system(size: 15, weight: .bold))
                .padding(.leading, 30)
                .foregroundStyle(Color.sejonggray)
                
            
            Divider()
                .frame(height: 1)
                .background(Color.sejonggray)
                .padding(.horizontal, 15)
                .offset(y:-25)
            
            Divider()
                .frame(height: 1)
                .background(Color.sejonggray)
                .padding(.horizontal, 15)
                .offset(y:25)
        }
        .padding(.horizontal, 10)
        .frame(height: 50)
    }
    
    // 상벌점 조회 버튼
    private var checkpoint: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            Button {
                // 상벌점 조회 화면 이동
                store.send(.pointButtonTapped)
            } label: {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 50)
            }
            Text("상벌점 조회")
                .font(.system(size: 15, weight: .bold))
                .padding(.leading, 30)
                .foregroundStyle(Color.sejonggray)
            
            
            
            Divider()
                .frame(height: 1)
                .background(Color.sejonggray)
                .padding(.horizontal, 15)
                .offset(y:25)
        }
        .offset(y:-7)
        .padding(.horizontal, 10)
        .frame(height: 50)
    }
    
    // 알림 버튼
    private var alaram: some View {
        HStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.sejonggray, lineWidth: 2)
                    .fill(Color.white)
                
                
                Toggle(isOn: $store.toggleIsOn.sending(\.toggleButtonTapped)) {
                        Text("알림")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Color.sejonggray)
                            .padding(.leading, 20)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color.sejonggray))
                    .padding(.trailing, 10)
            }
            .frame(width: 130, height: 40)
            .padding(.trailing, 25)
        }
    }
    
    // 로그아웃 버튼
    private var logoutButton: some View {
        Button {
            store.send(.logoutButtonTapped)
        } label: {
            Text("로그아웃")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(Color.sejonggray)
        }
        .padding(.top, 40)
    }
    
    // 문의 문구
    private var inquiry: some View {
        VStack {
            Text("문의")
            Text("kakaoTalk_ID: hwannow")
            Text(verbatim: "E-mail: qweijowe@gmail.com")
        }
        .font(.system(size: 10, weight: .bold))
        .foregroundStyle(Color.gray)
        .padding(.top, 5)
    }
}

#Preview {
    NavigationStack {
        MypageView(
            store: Store(
                initialState: MypageFeature.State(),
                reducer: { MypageFeature() }
            )
        )
    }
}
