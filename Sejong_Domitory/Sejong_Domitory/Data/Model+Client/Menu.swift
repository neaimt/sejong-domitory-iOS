// MARK: 식단 메뉴
import Foundation
import Dependencies


struct MealDay: Equatable, Hashable, Decodable  {
    var dayName: String
}

struct Menu: Equatable, Hashable, Decodable, Identifiable {
    var id: Int { menuId }
    var menuId: Int
    var date: String
    var lunch: String
    var dinner: String
}

struct MenuClient {
    var fetch: () async throws -> [Menu]
}

extension MenuClient: DependencyKey {
    static let liveValue = Self(
        fetch: {
            let url = URL(string: "\(serverURL)/menu")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([Menu].self, from: data)
        }
    )
}

extension DependencyValues {
    var menuClient: MenuClient {
        get { self[MenuClient.self] }
        set { self[MenuClient.self] = newValue }
    }
}
