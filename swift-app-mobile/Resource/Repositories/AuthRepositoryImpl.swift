import Foundation

final class AuthRepositoryImpl: AuthRepository {
    private let networkService: NetworkService
    private let keychainService: KeychainService

    init(networkService: NetworkService, keychainService: KeychainService) {
        self.networkService = networkService
        self.keychainService = keychainService
    }

    func logIn(credentials: LoginCredentials) async throws {
        let dto = LoginRequestDTO(username: credentials.username, password: credentials.password)
        let body = try networkService.encode(dto)

        let response: TokenResponseDTO = try await networkService.request(
            with: AuthNetworkConfig.login(body)
        )

        // Save token
        try keychainService.saveToken(response.data.accessToken)

        // Save user info
        let user = response.data.user.toDomain()
        AppUserDefaults.userId = user.id
        AppUserDefaults.userRole = user.role
        AppUserDefaults.isLoggedIn = true

        // Store in memory
        GlobalStorage.shared.user = user
    }

    func logOut() async throws {
        try await networkService.request(
            with: AuthNetworkConfig.logout,
            useToken: true
        )

        // Clear local data
        try keychainService.deleteToken()
        AppUserDefaults.clearAll()
        GlobalStorage.shared.user = nil
    }

    func register(email: String, password: String, firstName: String, lastName: String) async throws {
        let dto = RegisterRequestDTO(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName
        )
        let body = try networkService.encode(dto)

        try await networkService.request(with: AuthNetworkConfig.register(body))
    }

    func forgotPassword(email: String) async throws {
        let dto = ForgotPasswordRequestDTO(email: email)
        let body = try networkService.encode(dto)

        try await networkService.request(with: AuthNetworkConfig.forgotPassword(body))
    }
}
