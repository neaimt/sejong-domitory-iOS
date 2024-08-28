import SwiftUI
import ComposableArchitecture

struct ComplainDetailView: View {
    @Bindable var store: StoreOf<ComplainDetailFeature>
    
    var body: some View {
        VStack {
            Text(store.complain.title)
            Text(store.complain.name)
            Text(store.complain.detail.content)
        }
    }
}
