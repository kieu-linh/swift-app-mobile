import SwiftUI

struct MainCoordinatorView: View {
    let screenFactory: ScreenFactory
    @ObservedObject var coordinator: MainCoordinator
    var onLogout: () -> Void

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            screenFactory.makeHomeView(
                coordinator: coordinator,
                onLogout: onLogout
            )
            .navigationDestination(for: MainCoordinator.Screen.self) { screen in
                destination(screen)
            }
        }
    }

    @ViewBuilder
    private func destination(_ screen: MainCoordinator.Screen) -> some View {
        switch screen {
        case .home:
            screenFactory.makeHomeView(
                coordinator: coordinator,
                onLogout: onLogout
            )
        case .profile:
            ProfileView()
        case .settings:
            // TODO: Add SettingsView
            Text("Settings")
        }
    }
}
