import Foundation

final class AppFactory {
    // MARK: - Services

    private lazy var keychainService = KeychainService()

    private lazy var networkService = NetworkService(
        keychainService: keychainService
    )

    // MARK: - Repositories

    private lazy var authRepository: AuthRepository = AuthRepositoryImpl(
        networkService: networkService,
        keychainService: keychainService
    )
}

// MARK: - Auth UseCases

extension AppFactory {
    func makeLoginUseCase() -> LoginUseCase {
        LoginUseCase(authRepository: authRepository)
    }
}
