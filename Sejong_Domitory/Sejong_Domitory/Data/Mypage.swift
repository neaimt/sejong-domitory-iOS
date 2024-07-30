import Foundation

// MARK: 상벌점 확인
struct Point {
    var pointsHistory: [PointDetail]
    
    struct PointDetail {
        var id: Int
        var type: Bool // true 상점, false 벌점
        var cause: String // 사유
        var point: Int // 점수
        var grantDate: Date // 날짜
    }
}
