import Foundation

struct LoginState: Equatable {
    var username: String = ""
    var password: String = ""
    var viewState: ViewState = .idle
    var showPassword: Bool = false

    var isFormValid: Bool {
        !username.trimmed.isEmpty && !password.trimmed.isEmpty
    }

    var errorMessage: String? {
        if case .error(let message) = viewState {
            return message
        }
        return nil
    }

    var isLoading: Bool {
        viewState == .loading
    }
}

enum LoginEvent {
    case updateUsername(String)
    case updatePassword(String)
    case toggleShowPassword
    case login
    case navigateToRegister
    case navigateToForgotPassword
}
