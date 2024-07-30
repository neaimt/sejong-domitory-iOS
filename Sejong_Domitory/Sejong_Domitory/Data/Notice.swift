import Foundation

// MARK: 공지 목록
struct NoticeList {
    var page: Int
    var pageSize: Int
    var notices: [Notice]
    
    struct Notice {
        var noticeId: Int // 목록 번호
        var noticeTitle: String // 공지 제목
        var noticeWriter: String // 작성자
        var noticeCreatedAt: Date // 날짜
        var viewCount: Int // 조회수
        var pinned: Bool // 공지글이면 true
    }
}

// MARK: 공지내용
struct NoticeDetail {
    var id: Int
    var noticeTitle: String // 공지 제목
    var content: String // 공지 내용
    var noticeWriter: String // 작성자
    var noticeCreatedAt: Date // 날짜
    var noticeImgUrl: String // url 정보
    var attachedFile: String // 첨부파일 정보
}
