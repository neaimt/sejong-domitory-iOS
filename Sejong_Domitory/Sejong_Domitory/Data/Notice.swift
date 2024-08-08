import Foundation

// MARK: 공지 목록
struct NoticeList {
    var page: Int
    var pageSize: Int
    var notices: [Notice]

}

struct Notice: Hashable {
    var noticeId: Int // 목록 번호
    var noticeTitle: String // 공지 제목
    var noticeWriter: String // 작성자
    var noticeCreatedAt: String // 날짜
    var viewCount: Int // 조회수
    var pinned: Bool // 공지글이면 true
    var detail: NoticeDetail
}

// MARK: 공지내용
struct NoticeDetail: Hashable {
    var id: Int
    var noticeTitle: String // 공지 제목
    var content: String // 공지 내용
    var noticeWriter: String // 작성자
    var noticeCreatedAt: String // 날짜
    var noticeImgUrl: String // url 정보
    var attachedFile: String // 첨부파일 정보
}

// MARK: 임시 데이터
var noticeList = NoticeList(page: 1,
                            pageSize: 20,
                            notices: [
                                Notice(
                                    noticeId: 1,
                                    noticeTitle: "★★중간/정기퇴사 시 금액 환불 신청 방법 안내★★",
                                    noticeWriter: "행정실",
                                    noticeCreatedAt: "2023-07-25 12:34:56",
                                    viewCount: 123,
                                    pinned: false,
                                    detail: NoticeDetail(
                                        id: 1,
                                        noticeTitle: "★★중간/정기퇴사 시 금액 환불 신청 방법 안내★★",
                                        content: "중간/정기퇴사 시 금액 환불 신청 방법 안내 공지드립니다.",
                                        noticeWriter: "행정실",
                                        noticeCreatedAt: "2023-07-25 12:34:56",
                                        noticeImgUrl: "없음",
                                        attachedFile: "없음")
                                ),
                                
                                Notice(
                                    noticeId: 2,
                                    noticeTitle: "행정실 휴무 안내",
                                    noticeWriter: "행정실",
                                    noticeCreatedAt: "2023-07-25 12:34:56",
                                    viewCount: 111,
                                    pinned: false,
                                    detail: NoticeDetail(
                                        id: 2,
                                        noticeTitle: "행정실 휴무 안내",
                                        content: "행정실 휴무 날짜 공지합니다.",
                                        noticeWriter: "행정실",
                                        noticeCreatedAt: "2023-07-25 12:34:56",
                                        noticeImgUrl: "없음",
                                        attachedFile: "없음"))
                            ]
)
