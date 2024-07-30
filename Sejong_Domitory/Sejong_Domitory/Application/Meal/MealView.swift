import SwiftUI


struct Meal: Hashable {
    var hour: String
    var menu: String
}

var meal: [Meal] = [Meal(hour: "조식", menu: "식당 카페에 샐러드&샌드위치 예약하신 후 이용 가능합니다."), Meal(hour: "중식", menu: "쌀밥 채개장 돈육곤약장조림 탕평채 톳두부무침 배추김치"), Meal(hour: "석식", menu: "쌀밥 채개장 돈육곤약장조림 탕평채 톳두부무침 배추김치")]

struct MealView: View {
    @State var day = ["월", "화", "수", "목", "금", "토", "일"]
    @State var selectedDay: String?
    
    var body: some View {
        VStack {
            // 상단바 식단표
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
            
            // 요일 식단표
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.crimsonred, lineWidth: 3)
                    .fill(Color.white)
                    .frame(height: 31)
                    .padding(.horizontal, 50)
                
                SegmentedPicker(selection: $selectedDay, items: $day) { d in
                    Text(d)
                        .font(.system(size: 16, weight: .bold))
                        
                }
                .padding(.horizontal, 34)
                
            }
            .padding(.top, 50)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(height: 300)
                    .padding(.top, 20)
                    .shadow(radius: 3)
                
                VStack {
                    Text("7월 11일")
                        .font(.system(size: 16, weight: .bold))
                    
                    
                    ForEach(0..<3) { n in
                        Group {
                            Divider()
                                .frame(height: 1)
                                .background(Color.sejonggray)
                                
                            
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.sejonggray)
                                        .frame(width: 50, height: 40)
                                    Text("조식")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(Color.white)
                                        
                                }
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                                
                                
                                Spacer()
                                Text("식당 카페에 샐러드&샌드위치 예약하신 후 이용 가능합니다.")
                                    .font(.system(size: 14))
                                    .padding(.trailing, 10)
                            }
                        }
                        .padding(.horizontal, 30)
                    }
                }
                
            }
            .padding(.horizontal, 15)
            

            Spacer()
            
        }
        .ignoresSafeArea()
    
    }
}

#Preview {
    MealView()
}
