import SwiftUI

struct MypageView: View {
    var body: some View {
        @State var toggleisOn: Bool = true
        VStack {
            // 상단 마이페이지 바
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
            .ignoresSafeArea()
            
            Spacer()
                .frame(height: 10)
                
            // 프로필
            ZStack {
                Circle()
                    .fill(Color.white)
                    .stroke(Color.crimsonred)
                    .frame(width: 150, height: 150)
                    .shadow(radius: 2)
                
                Text("🥳")
                    .font(.system(size: 80))
            }
            
            // 사용자 이름
            Text("김은지")
                .font(.system(size: 20, weight: .bold))
            
            // 화면전환되는 버튼
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                
                Button {
                    // 기숙사 홈페이지 연결
                } label: {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 50)
                }
                
                    
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
            
            // 알림
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                
                Button {
                    // 상벌점 조회 화면 이동
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
            
            // 알림 버튼
            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.sejonggray, lineWidth: 2)
                        .fill(Color.white)
                    
                    
                    Toggle(isOn: $toggleisOn) {
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
        
            
            // 로그아웃
            Button {
                
            } label: {
                Text("로그아웃")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color.sejonggray)
            }
            .padding(.top, 40)
            
            // 문의
            VStack {
                Text("문의")
                Text("kakaoTalk_ID: hwannow")
                Text(verbatim: "E-mail: qweijowe@gmail.com")
            }
            .font(.system(size: 10, weight: .bold))
            .foregroundStyle(Color.gray)
            .padding(.top, 5)
            
            
            Spacer()
        }
    
    }
}

#Preview {
    MypageView()
}
