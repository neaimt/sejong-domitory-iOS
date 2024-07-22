import SwiftUI

struct NoticeView: View {
    @State var search: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            
            // 공지사항 글씨
            Text("공지사항")
                .font(.system(size: 20, weight: .bold))
                .padding(.leading, 25)
                .padding(.bottom, 20)
            
            
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
            
            // 리스트 스크롤 뷰로 제작
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 70)
                    .border(Color.search)
                    
                VStack(alignment: .leading) {
                    Text("행정실 / 1주전")
                        .font(.system(size: 10, weight: .bold))
                        .padding(.bottom, 10)
                    
                    Text("★★중간/정기퇴사 시 금액 환불 신청 방법 안내★★")
                        .font(.system(size: 14, weight: .bold))
                        .padding(.bottom, 10)
                }
                .padding(.leading, 10)
            }
        
            Spacer()
            
        }
    }
}

#Preview {
    NoticeView()
}
