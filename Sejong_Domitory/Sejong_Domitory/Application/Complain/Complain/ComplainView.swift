import SwiftUI

struct ComplainView: View {
    @State var search: String = ""
    @State var isShow: Bool = false
    
    // 민원 선택 바
    @State var title: String = "시설민원"
    
    var body: some View {
        VStack {
            // 상단바
            HStack {
                Button {
                    
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
                    isShow.toggle()
                } label: {
                    Text(title)
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
                            isPresented: $isShow,
                            actions: {
                                Button("시설민원") {
                                    title = "시설민원"
                                }
                                Button("생활 민원") {
                                    title = "생활민원"
                                }
                            }
                        )
            
                Spacer()
            }
            .padding(.top, 60)
            
            
            // 검색바
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.search)
                    .frame(height: 35)
                
                HStack {
                    Image("search")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    TextField("검색", text: $search)
                        .foregroundColor(Color.sejonggray)
                }
                .padding(.leading, 10)
            }
            .padding(.horizontal, 25)
            
            
            
            // 민원 종류에 따른 화면 불러오기
            if(title == "시설민원") {
                FacilityComplainView()
            }
            else {
                LifeComplainView()
            }
        

            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ComplainView()
}

