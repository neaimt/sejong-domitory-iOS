////
////  ex.swift
////  Sejong_Domitory
////
////  Created by 박근경 on 2024/07/23.
////
//
//import SwiftUI
//
//struct Book: Identifiable, Hashable {
//    var id: UUID { UUID() }
//    var title: String
//    var author: String
//}
//
//struct ex: View {
//    @State var day = ["월", "화", "수", "목", "금", "토", "일"]
//    @State var selectedDay: String?
//    
//    var body: some View {
//        VStack {
//            
//            SegmentedPicker(selection: $selectedDay, items: $day) { d in
//                Text(d)
//                    .font(.system(size: 14, weight: .bold))
//                    
//            }
//            
//            if let selectedDay {
//                HStack {
//                    Text("\(selectedDay)")
//                        .bold()
//                        .foregroundStyle(.cyan)
//                    
//                }.padding()
//            }
//        }
//    }
//}
//
//#Preview {
//    ex()
//}
