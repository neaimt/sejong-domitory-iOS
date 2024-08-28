import SwiftUI
import ComposableArchitecture

struct CheckPointView: View {
    @Bindable var store: StoreOf<CheckPointFeature>
    
    var body: some View {
        VStack {
            header
            
            allpoint
            
            ScrollView {
                pointContent()
                pointContent()
            }
            
            Spacer()
            
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
            HStack {
                Button {
                    // 뒤로가기 버튼 dimiss할 예정
                    store.send(.backButtonTapped)
                } label: {
                    Image(systemName: "lessthan")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 13, height: 22)
                        .foregroundStyle(Color.black)
                        .padding(.leading, 16)
                        .padding(.bottom, 10)
                }
                Spacer()
                Text("상벌점 확인")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 10)
                Spacer()
            }
        }
    }
    
    private var allpoint: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.sejonggray.opacity(0.5))
                    .foregroundStyle(Color.white)
                    .frame(height: 58)
                    .padding(10)
                Text("김은지님 상벌점 총합계: -1점")
                    .font(.system(size: 16, weight: .bold))
                
            }
            Divider()
                .foregroundStyle(Color.search)
                .offset(y:-5)
        }
    }
    
    private var pointBox: some View {
        VStack(alignment: .center) {
            Text("-3")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.crimsonred)
                .offset(y:3)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.crimsonred)
                    .frame(width: 50, height: 25)
                
                
                Text("벌점")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(Color.white)
            }
            .offset(y:-3)
            
            
        }
        .frame(width: 70, height: 60)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 70, height: 60)
                .foregroundColor(Color.white.opacity(0))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 236/255, green: 234/255, blue: 235/255),
                                lineWidth: 2)
                        .shadow(color: Color(red: 192/255, green: 189/255, blue: 191/255),
                                radius: 1.5, x: 1, y: 1)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 10)
                        )
                )
            
        }
    }
    
    @ViewBuilder func pointContent() -> some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 70)
                    
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("공동행사 및 생활점검 불참")
                            .font(.system(size: 14, weight: .bold))
                            .padding(.bottom, 5)
                        
                        Text("2024-04-29")
                            .font(.system(size: 10, weight: .bold))
                            .padding(.bottom, 5)
                    }
                    .foregroundStyle(Color.black)
                    .padding(.leading, 10)
                    
                    Spacer()
                    
                    pointBox
                        .padding(.trailing, 10)
                    
                    
                }
            }
            Divider()
                .foregroundStyle(Color.search)
                .offset(y:-5)
        }
    }
}

#Preview {
    CheckPointView(store: Store(initialState: CheckPointFeature.State(), reducer: {
        CheckPointFeature()
    }))
}
