import Foundation

// MARK: 시설민원 목록
struct FacilityList {
    var page: Int
    var pageSize: Int
    var complaints: [Complaint]
}

struct Complaint: Hashable {
    var complainId: Int
    var title: String
    var name: String
    var createdAt: String
    var status: Bool
    var detail: FacilityDetail
}

// MARK: 시설민원 글
struct FacilityDetail: Hashable {
    var title: String // 제목
    var name: String // 작성자
    var createdAt: String // 날짜
    var status: Bool // 처리 상태
    var content: String // 내용
}

var facilitys = FacilityList(page: 1, pageSize: 20,
                            complaints: [
                                Complaint(complainId: 1, title: "[기숙사] 냉방 고장 신고", name: "김은지", createdAt: "2024-07-05", status: true, 
                                          detail: FacilityDetail(title: "[기숙사] 냉방 고장 신고", name: "김은지", createdAt: "2024-07-05", status: true, content: "냉장고 고장")),
                                Complaint(complainId: 2, title: "[기숙사] 난방 고장 신고", name: "김은지", createdAt: "2024-07-25", status: false,
                                          detail: FacilityDetail(title: "[기숙사] 난방 고장 신고", name: "김은지", createdAt: "2024-07-25", status: false, content: "난방 고장 너무 추워요"))
                            ]
)

var lifes = FacilityList(page: 1, pageSize: 20,
                            complaints: [
                                Complaint(complainId: 1, title: "[기숙사] 호실 내 벌레", name: "김은지", createdAt: "2024-07-05", status: true,
                                          detail: FacilityDetail(title: "[기숙사] 냉방 고장 신고", name: "김은지", createdAt: "2024-07-05", status: true, content: "호실 내 벌레가 너무 많아요")),
                                Complaint(complainId: 2, title: "[기숙사] 화장실 변기 막힘", name: "김은지", createdAt: "2024-07-25", status: false,
                                          detail: FacilityDetail(title: "[기숙사] 화장실 변기 막힘", name: "김은지", createdAt: "2024-07-25", status: false, content: "화장실 변기 좀 뚫어주세요"))
                            ]
)


// MARK: 생활민원 목록
// MARK: 생활민원 글
