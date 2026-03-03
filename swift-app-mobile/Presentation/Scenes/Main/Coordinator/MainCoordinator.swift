import Foundation

@MainActor
final class MainCoordinator: Coordinator, MainCoordinatorProtocol {
    enum Screen: Routable {
        case home
        case profile
        case settings
    }

    @Published var navigationPath = [Screen]()

    func showHome() {
        push(.home)
    }

    func showProfile() {
        push(.profile)
    }

    func showSettings() {
        push(.settings)
    }

    func goBack() {
        pop()
    }
}
