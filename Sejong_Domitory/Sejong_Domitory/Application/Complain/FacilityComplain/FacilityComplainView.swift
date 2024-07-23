import SwiftUI

struct FacilityComplainView: View {
    
    var body: some View {
        VStack {
            ScrollView {
                // 리스트 스크롤 뷰로 제작
                VStack {
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 70)
                            
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("605호 변기 막힘")
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.bottom, 5)
                                
                                Text("최지후 | 2024-07-11")
                                    .font(.system(size: 10, weight: .bold))
                                    .padding(.bottom, 5)
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.complain)
                                    .frame(width: 50, height: 25)
                                
                                Text("처리중")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(Color.white)
                            }
                            .padding(.trailing, 20)
                        }
                    }
                    Divider()
                        .foregroundStyle(Color.search)
                        .offset(y:-5)
                }
                VStack {
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 70)
                            
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("605호 변기 막힘")
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.bottom, 5)
                                
                                Text("최지후 | 2024-07-11")
                                    .font(.system(size: 10, weight: .bold))
                                    .padding(.bottom, 5)
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.complain)
                                    .frame(width: 50, height: 25)
                                
                                Text("처리중")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(Color.white)
                            }
                            .padding(.trailing, 20)
                        }
                    }
                    Divider()
                        .foregroundStyle(Color.search)
                        .offset(y:-5)
                }
                .offset(y:-10)
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
}

#Preview {
    FacilityComplainView()
}
