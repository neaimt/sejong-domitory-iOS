import ComposableArchitecture
import SwiftUI

struct LoginView: View {
    @Bindable var store: StoreOf<LoginFeature>
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                    .frame(height: 60)
                
                logo//로고
                
                Spacer()
                    .frame(height: 30)
                
                id //아이디
                pw //비밀번호
                check // 개인정보 처리 방침 확인
                
                Spacer()
                
                loginButton// 로그인 버튼
            }
            .ignoresSafeArea(.keyboard)
        }
//        .fullScreenCover(
//              item: $store.scope(state: \.TabView, action: \.TabView)
//            ) { TabViewStore in
//              NavigationStack {
//                  TabView(store: Store(initialState: store.TabView!,
//                                       reducer: {
//                      TabFeature()
//                  }))
//                  
//              }
//            }
//            .transaction { transaction in
//                transaction.disablesAnimations = true
//            }
    }
    
    // 세종대 로고
    private var logo: some View {
        Image("sejongLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
    }
    // 아이디
    private var id: some View {
        VStack(alignment: .leading)  {
            Text("아이디")
                .padding(.leading, 15)
                .font(.system(size: 15, weight: .bold))
                .offset(y:10)
            Spacer()
            TextField("아이디를 입력해주세요", text: $store.id)
                .textFieldStyle(LoginTextfieldStyle())
        }
        .frame(height: 68)
    }
    
    // 비밀번호
    private var pw: some View {
        VStack(alignment: .leading)  {
            Text("비밀번호")
                .padding(.leading, 15)
                .font(.system(size: 15, weight: .bold))
                .offset(y:10)
            Spacer()
            SecureField("비밀번호를 입력해주세요", text: $store.pw)
                .textFieldStyle(LoginTextfieldStyle())
                
        }
        .frame(height: 68)
    }
    
    // 개인정보처리방침 버튼
    private var check: some View {
        HStack {
            Text("개인정보 처리 방침 확인하기")
                .padding( 15)
                .font(.system(size: 12, weight: .bold))
                .underline()
                .foregroundStyle(Color.gray)
            Spacer()
        }
    }
    
    // 로그인 버튼
    private var loginButton: some View {
        Button {
            store.send(.loginButtonTapped)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.crimsonred)
                    .frame(height: 50)
                Text("로그인")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 18, weight: .bold))
            }
            .padding(.horizontal, 50)
        }
    }
}

#Preview {
  LoginView(
    store: Store(initialState: LoginFeature.State()) {
      LoginFeature()
    }
  )
}
