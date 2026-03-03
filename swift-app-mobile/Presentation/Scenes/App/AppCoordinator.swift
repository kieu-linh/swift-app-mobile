import Foundation

@MainActor
final class AppCoordinator: ObservableObject {
    enum State {
        case idle
        case loading
        case auth
        case main
    }

    enum Action {
        case checkAuthorization
        case showAuth
        case showMain
    }

    @Published private(set) var state: State

    init() {
        state = .idle
    }

    func handle(_ action: Action) {
        switch action {
        case .checkAuthorization:
            Task { await checkAuth() }
        case .showAuth:
            state = .auth
        case .showMain:
            state = .main
        }
    }
}

// MARK: - Private

private extension AppCoordinator {
    func checkAuth() async {
        // Show splash for a moment
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        state = .loading

        do {
            let token = try KeychainService.shared.getToken()

            if token == nil {
                try? KeychainService.shared.deleteToken()
                state = .auth
            } else {
                state = .main
            }
        } catch {
            state = .auth
        }
    }
}
