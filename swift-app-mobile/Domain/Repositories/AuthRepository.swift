import Foundation

protocol AuthRepository {
    func logIn(credentials: LoginCredentials) async throws
    func logOut() async throws
    func register(email: String, password: String, firstName: String, lastName: String) async throws
    func forgotPassword(email: String) async throws
}
