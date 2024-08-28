import SwiftUI
import ComposableArchitecture

struct FacilityComplainView: View {
    @Bindable var store: StoreOf<FacilityComplainFeature>
    
    var body: some View {
        VStack {
            ScrollView {
                
                ForEach(store.complain, id: \.self) { content in
                    NavigationLink(state: ComplainDetailFeature.State(complain: content)) {
                        complain(complain: content)
                    }
                }
            }
            
            // 글쓰기 버튼
            HStack {
                Spacer()
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.crimsonred)
                            .frame(width:80, height: 40)
                        Text("글쓰기")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color.white)
                    }
                }
                .padding(.trailing, 25)
                .padding(.bottom, 20)
            }
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder func complain(complain: Complaint) -> some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 70)
                    
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(complain.title)")
                            .font(.system(size: 14, weight: .bold))
                            .padding(.bottom, 5)
                        
                        Text("\(complain.name) | \(complain.createdAt)")
                            .font(.system(size: 10, weight: .bold))
                            .padding(.bottom, 5)
                    }
                    .foregroundStyle(Color.black)
                    .padding(.leading, 10)
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.complain)
                            .frame(width: 50, height: 25)
                        
                        if complain.status {
                            Text("처리완료")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(Color.white)
                        }
                        else {
                            Text("처리중")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(Color.white)
                        }
                    }
                    .padding(.trailing, 20)
                }
            }
            Divider()
                .foregroundStyle(Color.search)
                .offset(y:-5)
        }
    }
}

#Preview {
    FacilityComplainView(store: Store(initialState: FacilityComplainFeature.State(complain: facilitys.complaints), reducer: {FacilityComplainFeature()}))
}
