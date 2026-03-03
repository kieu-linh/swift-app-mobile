import Foundation

enum AuthNetworkConfig: NetworkConfig {
    case login(Data)
    case register(Data)
    case logout
    case forgotPassword(Data)

    var path: String {
        "auth/"
    }

    var endPoint: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "register"
        case .logout:
            return "logout"
        case .forgotPassword:
            return "forgot-password"
        }
    }

    var task: HTTPTask {
        switch self {
        case .login(let data):
            return .requestBody(data)
        case .register(let data):
            return .requestBody(data)
        case .logout:
            return .request
        case .forgotPassword(let data):
            return .requestBody(data)
        }
    }

    var method: HTTPMethod {
        return .post
    }
}
