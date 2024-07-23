//
//  LifeComplainView.swift
//  Sejong_Domitory
//
//  Created by 박근경 on 2024/07/12.
//

import SwiftUI

struct LifeComplainView: View {
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
                                Text("호실 내 벌레")
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
                                
                                Text("비공개")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(Color.white)
                            }
                            .padding(.trailing, 20)
                        }
                    }
                }
                
                Divider()
                    .foregroundStyle(Color.search)
                    .offset(y:-5)
                
            }
            
            Spacer()
            
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
    LifeComplainView()
}
