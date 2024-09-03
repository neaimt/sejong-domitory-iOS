import Foundation
import Dependencies

//// MARK: 공지 목록
//struct NoticeList: Equatable, Hashable, Decodable, Identifiable {
//    var id: Int { page }
//    var page: Int
//    var pageSize: Int
//    var notices: [Notice]
//}


// MARK: 공지목록 + Client
struct Notice: Equatable, Hashable, Decodable, Identifiable {
    var id: Int { noticeId }
    var noticeId: Int // 목록 번호
    var noticeTitle: String // 공지 제목
    var noticeWriter: String // 작성자
    var noticeCreatedAt: String // 날짜
    var viewCount: Int // 조회수
    var pinned: Bool // 공지글이면 true
}


struct NoticeClient {
    var fetch: () async throws -> [Notice]
}

extension NoticeClient: DependencyKey {
    static let liveValue = Self(
        fetch: {
            let url = URL(string: "https://3207-211-243-13-74.ngrok-free.app/notice")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([Notice].self, from: data)
        }
    )
}

extension DependencyValues {
    var noticeClient: NoticeClient {
        get { self[NoticeClient.self] }
        set { self[NoticeClient.self] = newValue }
    }
}


// MARK: 공지내용  + Client
struct NoticeDetail: Equatable, Hashable, Decodable, Identifiable {
    var id: Int { noticeId }
    var noticeId: Int
    var noticeTitle: String
    var noticeContent: String
    var noticeWriter: String
    var noticeCreatedAt: String // 날짜를 문자열로 처리
    var attachedFiles: [AttachedFile]
    
    enum CodingKeys: String, CodingKey {
        case noticeId
        case noticeTitle
        case noticeContent
        case noticeWriter
        case noticeCreatedAt = "notoceCreatedAt" // JSON 키와 모델 키가 다른 경우 매핑
        case attachedFiles
    }
}
struct AttachedFile: Equatable, Hashable, Decodable, Identifiable {
    var id: Int { attachedFileID }
    var attachedFileID: Int
    var attachedFileName: String
    var attachedFileUrl: String
    
    enum CodingKeys: String, CodingKey {
        case attachedFileID
        case attachedFileName
        case attachedFileUrl
    }
}

struct NoticeDetailClient {
    var fetch: (_ url: URL) async throws -> NoticeDetail
}

extension NoticeDetailClient: DependencyKey {
    static let liveValue = Self(
        fetch: { url in
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(NoticeDetail.self, from: data)
        }
    )
}

extension DependencyValues {
    var noticeDetailClient: NoticeDetailClient {
        get { self[NoticeDetailClient.self] }
        set { self[NoticeDetailClient.self] = newValue }
    }
}

