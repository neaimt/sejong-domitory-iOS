import SwiftUI
import ComposableArchitecture

struct ComplainView: View {
    @Bindable var store: StoreOf<ComplainFeature>
    
    var body: some View {
        // 민원 종류에 따른 화면 불러오기
        if(store.title == "시설민원") {
            NavigationStack(path: $store.scope(state: \.facilityState.path, action: \.facilityAction.path)) {
                VStack {
                    // 상단바
                    header
                        .padding(.top, 60)
                    
                    search
                        .padding(.horizontal, 25)
                    
                    FacilityComplainView(store: store.scope(state: \.facilityState, action: \.facilityAction))
          
                    Spacer()
                }
                .ignoresSafeArea()
            } destination: { store in
                ComplainDetailView(store: store)
            }
        }
        
        else if (store.title == "생활민원") {
            NavigationStack(path: $store.scope(state: \.lifeState.path, action: \.lifeAction.path)) {
                VStack {
                    // 상단바
                    header
                        .padding(.top, 60)
                    
                    search
                        .padding(.horizontal, 25)
                   
                   
                    LifeComplainView(store: store.scope(state: \.lifeState, action: \.lifeAction))
                    
                    
                    Spacer()
                }
                .ignoresSafeArea()
            } destination: { store in
                ComplainDetailView(store: store)
            }
        }
        
    }
    
    // 상단바
    private var header: some View {
        HStack {
            Button {
                store.send(.backButtonTapped)
            } label: {
                Image(systemName: "lessthan")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 13, height: 22)
                    .foregroundStyle(Color.black)
                    .padding(.leading, 16)
            }
            
            Spacer()
            
            Button {
                store.send(.showDialog(true))
            } label: {
                Text(store.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.black)
                Image(systemName: "chevron.down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.black)
                    .padding(.leading, 16)
            }
            .confirmationDialog(
                "제목",
                isPresented: $store.isShow,
                actions: {
                    Button("시설민원") {
                        store.send(.typeButtonTapped("시설민원"))
                    }
                    Button("생활 민원") {
                        store.send(.typeButtonTapped("생활민원"))
                    }
                }
            )
            
            Spacer()
        }
    }
    
    // 검색바
    private var search: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.search)
                .frame(height: 35)
            
            HStack {
                Image("search")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                TextField("검색", text: $store.search)
                    .foregroundColor(Color.sejonggray)
            }
            .padding(.leading, 10)
        }
    }
}

#Preview {
    ComplainView(store: Store(initialState: ComplainFeature.State(), reducer: {
        ComplainFeature()
    }))
}

