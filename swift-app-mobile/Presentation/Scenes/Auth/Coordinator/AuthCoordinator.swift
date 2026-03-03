import Foundation

@MainActor
final class AuthCoordinator: Coordinator, AuthCoordinatorProtocol {
    enum Screen: Routable {
        case login
        case register
        case forgotPassword
    }

    @Published var navigationPath = [Screen]()

    func showLogin() {
        push(.login)
    }

    func showRegister() {
        push(.register)
    }

    func showForgotPassword() {
        push(.forgotPassword)
    }

    func goBack() {
        pop()
    }
}
