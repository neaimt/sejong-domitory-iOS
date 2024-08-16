import SwiftUI

// MARK: 탭바 아이템 enum
enum TabBarItem: Hashable, Equatable {
    case notice, complain, meal, mypage
    
    var iconName: String {
        switch self {
        case .notice:
            return "home"
        case .complain:
            return "complain"
        case .meal:
            return "meal"
        case .mypage:
            return "mypage"
        }
    }
        
        var title: String {
            switch self {
            case .notice:
                return "공지"
            case .complain:
                return "민원"
            case .meal:
                return "식단"
            case .mypage:
                return "마이페이지"
            }
        }
}



