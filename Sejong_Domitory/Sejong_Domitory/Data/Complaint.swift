import Foundation

// MARK: 시설민원 목록
struct FacilityList {
    var page: Int
    var pageSize: Int
    var complaints: [Complaint]
    struct Complaint {
        var complainId: Int
        var title: String
        var name: String
        var createdAt: Date
        var status: Bool
    }
}
// MARK: 시설민원 글
struct FacilityDetail {
    var title: String // 제목
    var name: String // 작성자
    var createdAt: Date // 날짜
    var status: Bool // 처리 상태
    var content: String // 내용
}

// MARK: 생활민원 목록
// MARK: 생활민원 글
