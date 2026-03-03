import Foundation

enum Environment {
    case development
    case staging
    case production
}

final class AppConfig {
    static let shared = AppConfig()

    let environment: Environment = .development

    var baseURL: String {
        switch environment {
        case .development:
            return "https://api-dev.example.com/api/"
        case .staging:
            return "https://api-staging.example.com/api/"
        case .production:
            return "https://api.example.com/api/"
        }
    }

    var baseSocketURL: String {
        switch environment {
        case .development:
            return "https://socket-dev.example.com"
        case .staging:
            return "https://socket-staging.example.com"
        case .production:
            return "https://socket.example.com"
        }
    }

    static let defaultAvatar = "default_avatar"
}
