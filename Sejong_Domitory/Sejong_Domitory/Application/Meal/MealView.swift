import SwiftUI
import ComposableArchitecture

struct MealView: View {
    
    @Namespace private var pickerTransition // 애니메이션 가능하게 해줌
    @Bindable var store: StoreOf<MealFeature>
    
    var body: some View {
        VStack {
            // 상단바 식단표
            header
            
            // 요일 버튼
            dayPicker
            .padding(.top, 50)
            
            // 식단표
            if store.menus.indices.contains(dayToNumber(day: store.selectedDay?.dayName) ?? 0) {
                // 인덱스가 유효하면 배열에 접근
                let menu = store.menus[dayToNumber(day: store.selectedDay?.dayName) ?? 0]
                mealBoard(menu: menu)
                    .padding(.horizontal, 15)
            } else {
                Text("No menu available")
            }

            Spacer()
            
        }
        .onAppear {
            print("MealView 나타남")
            store.send(.setInitialSelection)
            store.send(.onAppear)
          
        }
        .overlay {
            if store.isLoading {
                ProgressView()
            }
        }
        .alert(store: store.scope(state: \.$alert, action: { .alert($0) }))
        .ignoresSafeArea()
    }
    
    
    // 상단 헤더 + 식단표 이미지
    private var header: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Rectangle()
                .fill(Color.white)
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 10,
                        bottomTrailingRadius: 10,
                        topTrailingRadius: 0)
                )
                .frame(height: 240)
                .shadow(color: Color.sejonggray, radius: 1)
                .offset(y: -2)
            
            VStack {
                Text("식단표")
                    .font(.system(size: 20, weight: .bold))
                Image("mealBoard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
                    .padding(.bottom, 20)
            }
            
        }
    }
    
    // 커스텀피커 함수
    @ViewBuilder func customPicker<Content: View>(
        selection: Binding<MealDay?>,
        items: Binding<[MealDay]>,
        selectionColor: Color = .crimsonred,
        @ViewBuilder content: @escaping (MealDay) -> Content
    ) -> some View {
        ScrollViewReader { proxy in
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 0) {
                ForEach(items.wrappedValue, id:\.self) { item in
                    let selected = selection.wrappedValue == item
                    ZStack {
                        if selected {
                            Capsule()
                                .foregroundStyle(
                                    selectionColor.gradient.shadow(.inner(color: .black.opacity(0.5), radius: 1, x: 0, y: 0))
                                )
                                .matchedGeometryEffect(id: "picker", in: pickerTransition)
                                
                            content(item)
                                .id(item)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .lineLimit(1)
                                .clipShape(Capsule())
                                .shadow(radius: 10)
                        } else {
                            Capsule()
                                .foregroundStyle(.clear)
                            
                            content(item)
                                .id(item)
                                .foregroundStyle(Color.sejonggray)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .lineLimit(1)
                                .clipShape(Capsule())
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            _ = store.send(.daySelected(item))
                        }
                    }
                    .onChange(of: item) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            proxy.scrollTo(item)
                        }
                    }
                    
                }
            }
            .padding(.horizontal)
            .fixedSize(horizontal: false, vertical: true)
        }
    }

    
    // 요일 피커
    private var dayPicker: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color.crimsonred, lineWidth: 3)
                .fill(Color.white)
                .frame(height: 31)
                .padding(.horizontal, 50)
            
            customPicker(selection: $store.selectedDay, items: $store.day) { item in
                Text(item.dayName)
                    .font(.system(size: 16, weight: .bold))
            }
                .padding(.horizontal, 34)
        }
    }
    
    // 식단표
    @ViewBuilder func mealBoard(menu: Menu)-> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(height: 300)
                .padding(.top, 20)
                .shadow(radius: 3)
            
            VStack {
                Text(menu.date)
                    .font(.system(size: 16, weight: .bold))
                
                // 조식
                hourMenu(hour: "조식", menu: "식당 카페에 샐러드& 샌드위치 예약 하신 후 이용 가능합니다.")
                // 중식
                hourMenu(hour: "중식", menu: menu.lunch)
                
                // 석식
                hourMenu(hour: "석식", menu: menu.dinner)
            
            }
            
        }
    }
    
    // 조식 중식 석식 메뉴 리스트
    @ViewBuilder func hourMenu(hour: String, menu: String) -> some View {
        Group {
            Divider()
                .frame(height: 1)
                .background(Color.sejonggray)
            
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.sejonggray)
                        .frame(width: 50, height: 40)
                    Text(hour)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.white)
                    
                }
                .padding(.leading, 10)
                .padding(.top, 10)
                
                
                
                Text(menu)
                    .font(.system(size: 14))
                    .padding(.leading, 10)
                
                Spacer()
            }
        }
        .padding(.horizontal, 30)
    }
    
    
    // 요일을 숫자로 매핑
    func dayToNumber(day: String?) -> Int? {
        guard let day = day else { return nil }
        
        let dayMapping: [String: Int] = [
            "월": 0,
            "화": 1,
            "수": 2,
            "목": 3,
            "금": 4,
            "토": 5,
            "일": 6
        ]
        
        return dayMapping[day]
    }
}

#Preview {
    MealView(
        store: Store(
            initialState: MealFeature.State(),
            reducer: {
                MealFeature()
            }))
}
