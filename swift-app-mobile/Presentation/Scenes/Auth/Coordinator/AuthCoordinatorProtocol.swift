import Foundation

@MainActor
protocol AuthCoordinatorProtocol: AnyObject {
    func showLogin()
    func showRegister()
    func showForgotPassword()
    func goBack()
}
