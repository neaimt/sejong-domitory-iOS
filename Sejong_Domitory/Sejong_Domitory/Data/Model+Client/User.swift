import Dependencies
import Foundation

struct User: Encodable {
    var userId: String
    var password: String
}

struct LoginRecord: Codable, Equatable {
    var loginRecordId: Int
    var cookies: String
    var loginTime: String
    
    enum CodingKeys: String, CodingKey {
        case loginRecordId
        case cookies
        case loginTime
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        loginRecordId = try container.decode(Int.self, forKey: .loginRecordId)
        cookies = try container.decode(String.self, forKey: .cookies)
        loginTime = try container.decode(String.self, forKey: .loginTime)
    }
}

// MARK: - API Client
struct AuthClient {
    var login: (User) async throws -> LoginRecord
}

extension AuthClient: DependencyKey {
    static let liveValue = Self(
        login: { user in
            let url = URL(string: "\(serverURL)/login/perform-login")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(user)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(LoginRecord.self, from: data)
        }
    )
}

extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}

enum APIError: Error {
    case invalidResponse
}
