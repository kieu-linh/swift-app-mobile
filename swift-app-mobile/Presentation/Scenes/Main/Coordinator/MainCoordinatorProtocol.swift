import Foundation

@MainActor
protocol MainCoordinatorProtocol: AnyObject {
    func showHome()
    func showProfile()
    func showSettings()
    func goBack()
}
