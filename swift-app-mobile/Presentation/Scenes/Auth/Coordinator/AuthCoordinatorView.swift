import SwiftUI

struct AuthCoordinatorView: View {
    let screenFactory: ScreenFactory
    @ObservedObject var coordinator: AuthCoordinator
    var onLoginSuccess: () -> Void

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            screenFactory.makeLoginView(
                coordinator: coordinator,
                onLoginSuccess: onLoginSuccess
            )
            .navigationDestination(for: AuthCoordinator.Screen.self) { screen in
                destination(screen)
            }
        }
    }

    @ViewBuilder
    private func destination(_ screen: AuthCoordinator.Screen) -> some View {
        switch screen {
        case .login:
            screenFactory.makeLoginView(
                coordinator: coordinator,
                onLoginSuccess: onLoginSuccess
            )
        case .register:
            // TODO: Add RegisterView
            Text("Register")
        case .forgotPassword:
            // TODO: Add ForgotPasswordView
            Text("Forgot Password")
        }
    }
}
