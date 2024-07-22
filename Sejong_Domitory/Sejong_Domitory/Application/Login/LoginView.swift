import ComposableArchitecture
import SwiftUI

struct LoginView: View {
    @State var store: StoreOf<LoginFeature>
    
    var body: some View {
    
        VStack {
            Spacer()
                .frame(height: 60)
            Image("sejongLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Spacer()
                .frame(height: 30)
            
            //아이디
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
            
            //비밀번호
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
            
            
            // 개인정보 처리 방침 확인
            HStack {
                Text("개인정보 처리 방침 확인하기")
                    .padding( 15)
                    .font(.system(size: 12, weight: .bold))
                    .underline()
                    .foregroundStyle(Color.gray)
                Spacer()
            }
            
            Spacer()
            
            // 로그인 버튼
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
        .ignoresSafeArea(.keyboard)
        
    }
}

#Preview {
  LoginView(
    store: Store(initialState: LoginFeature.State()) {
      LoginFeature()
    }
  )
}
