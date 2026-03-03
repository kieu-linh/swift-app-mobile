import SwiftUI

@MainActor
final class ScreenFactory {
    private let appFactory: AppFactory

    init(appFactory: AppFactory) {
        self.appFactory = appFactory
    }
}

// MARK: - Auth Screens

protocol LoginViewFactory {
    func makeLoginView(
        coordinator: AuthCoordinatorProtocol,
        onLoginSuccess: @escaping () -> Void
    ) -> LoginView<LoginViewModel>
}

extension ScreenFactory: LoginViewFactory {
    func makeLoginView(
        coordinator: AuthCoordinatorProtocol,
        onLoginSuccess: @escaping () -> Void
    ) -> LoginView<LoginViewModel> {
        let viewModel = LoginViewModel(
            coordinator: coordinator,
            loginUseCase: appFactory.makeLoginUseCase(),
            onLoginSuccess: onLoginSuccess
        )
        return LoginView(viewModel: viewModel)
    }
}

// MARK: - Main Screens

protocol HomeViewFactory {
    func makeHomeView(
        coordinator: MainCoordinatorProtocol,
        onLogout: @escaping () -> Void
    ) -> HomeView<HomeViewModel>
}

extension ScreenFactory: HomeViewFactory {
    func makeHomeView(
        coordinator: MainCoordinatorProtocol,
        onLogout: @escaping () -> Void
    ) -> HomeView<HomeViewModel> {
        let viewModel = HomeViewModel(
            coordinator: coordinator,
            onLogout: onLogout
        )
        return HomeView(viewModel: viewModel)
    }
}
