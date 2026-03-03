import SwiftUI

struct AppCoordinatorView: View {
    let screenFactory: ScreenFactory
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        Group {
            switch coordinator.state {
            case .idle:
                SplashScreenView()
                    .onAppear {
                        coordinator.handle(.checkAuthorization)
                    }

            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)

            case .auth:
                AuthCoordinatorView(
                    screenFactory: screenFactory,
                    coordinator: AuthCoordinator(),
                    onLoginSuccess: {
                        coordinator.handle(.showMain)
                    }
                )

            case .main:
                MainCoordinatorView(
                    screenFactory: screenFactory,
                    coordinator: MainCoordinator(),
                    onLogout: {
                        coordinator.handle(.showAuth)
                    }
                )
            }
        }
        .animation(.easeInOut, value: coordinator.state)
    }
}
