import SwiftUI
import ComposableArchitecture

struct ComplainDetailView: View {
    @Bindable var store: StoreOf<ComplainDetailFeature>
    
    var body: some View {
        VStack {
            header
            Divider()
                .padding(.bottom, 10)
            
            Text(store.complain.title)
                .font(.system(size: 18, weight: .bold))
            Text("\(store.complain.name) | \(store.complain.createdAt)")
                .font(.system(size: 12, weight: .bold))
            
            Divider()
                .padding(.bottom, 10)
            
            Text(store.complain.detail.content)
                .font(.system(size: 14))
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
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
        }
    }
}

#Preview {
    ComplainDetailView(store: Store(initialState: ComplainDetailFeature.State(complain: facilitys.complaints[0]), reducer: {ComplainDetailFeature()}))
}
