import Foundation

@MainActor
final class LoginViewModel: ViewModel {
    @Published var state: LoginState

    private let coordinator: AuthCoordinatorProtocol
    private let loginUseCase: LoginUseCase
    private let onLoginSuccess: () -> Void

    init(
        coordinator: AuthCoordinatorProtocol,
        loginUseCase: LoginUseCase,
        onLoginSuccess: @escaping () -> Void
    ) {
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
        self.onLoginSuccess = onLoginSuccess
        self.state = LoginState()
    }

    func handle(_ event: LoginEvent) {
        switch event {
        case .updateUsername(let value):
            state.username = value
        case .updatePassword(let value):
            state.password = value
        case .toggleShowPassword:
            state.showPassword.toggle()
        case .login:
            performLogin()
        case .navigateToRegister:
            coordinator.showRegister()
        case .navigateToForgotPassword:
            coordinator.showForgotPassword()
        }
    }
}

// MARK: - Private

private extension LoginViewModel {
    func performLogin() {
        guard state.isFormValid else { return }

        state.viewState = .loading

        Task {
            do {
                try await loginUseCase.execute(
                    username: state.username.trimmed,
                    password: state.password
                )
                state.viewState = .success
                onLoginSuccess()
            } catch {
                state.viewState = .error(error.localizedDescription)
                logError("Login failed: \(error)")
            }
        }
    }
}
