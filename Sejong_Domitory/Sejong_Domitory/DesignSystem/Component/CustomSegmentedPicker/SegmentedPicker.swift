import SwiftUI

struct SegmentedPicker<SelectionValue, Content>: View
       where SelectionValue: Hashable, Content: View {
    // 1.
    @Binding var selection: SelectionValue?

    // 2.
    @Binding var items: [SelectionValue]

    // 3.
    private var selectionColor: Color = .crimsonred

    // 4.
    private var content: (SelectionValue) -> Content

    @Namespace private var pickerTransition
    
    init(
        selection: Binding<SelectionValue?>,
        items: Binding<[SelectionValue]>,
        selectionColor: Color = .crimsonred,
        @ViewBuilder content: @escaping (SelectionValue) -> Content
    ) {
        _selection = selection
        _items = items
        self.selectionColor = selectionColor
        self.content = content
    }
    
    var body: some View {
        // 1.
        ScrollViewReader { proxy in
            // 2.
//            ScrollView(.horizontal, showsIndicators: false) {
                // 3.
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 0) {
                    ForEach(items, id:\.self) { item in
                        // 1.
                        let selected = selection == item
                        ZStack {
                            if selected {
                                Capsule()
                                    .foregroundStyle(
                                        selectionColor.gradient.shadow(.inner(color: .black.opacity(0.5), radius: 1, x: 0, y: 0))
                                    )
                                    .matchedGeometryEffect(id: "picker", in: pickerTransition)
                                    
                                content(item).id(item)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .lineLimit(1)
                                    .clipShape(Capsule())
                                    .shadow(radius: 10)
                            }
                            else {
                                Capsule()
                                    .foregroundStyle(.clear)
                                
                                content(item).id(item)
                                    .foregroundStyle(Color.sejonggray)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .lineLimit(1)
                                    .clipShape(Capsule())
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selection = item
                            }
                        }
                        .onChange(of: selection) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                proxy.scrollTo(selection)
                            }
                        }
                    }
                    .onAppear {
                        // 2.
                        if selection == nil, let first = items.first {
                            selection = first
                        }
                    }
                }
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
            }
//        }
    }
    
}
