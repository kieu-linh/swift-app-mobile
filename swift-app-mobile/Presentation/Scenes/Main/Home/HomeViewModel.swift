import Foundation

struct HomeState: Equatable {
    var viewState: ViewState = .idle
    var userName: String = ""
}

enum HomeEvent {
    case onAppear
    case logout
    case navigateToProfile
    case navigateToSettings
}

@MainActor
final class HomeViewModel: ViewModel {
    @Published var state: HomeState

    private let coordinator: MainCoordinatorProtocol
    private let onLogout: () -> Void

    init(coordinator: MainCoordinatorProtocol, onLogout: @escaping () -> Void) {
        self.coordinator = coordinator
        self.onLogout = onLogout
        self.state = HomeState()
    }

    func handle(_ event: HomeEvent) {
        switch event {
        case .onAppear:
            loadData()
        case .logout:
            performLogout()
        case .navigateToProfile:
            coordinator.showProfile()
        case .navigateToSettings:
            coordinator.showSettings()
        }
    }
}

// MARK: - Private

private extension HomeViewModel {
    func loadData() {
        state.userName = GlobalStorage.shared.user?.fullName ?? "User"
    }

    func performLogout() {
        try? KeychainService.shared.deleteToken()
        AppUserDefaults.clearAll()
        GlobalStorage.shared.clear()
        onLogout()
    }
}
