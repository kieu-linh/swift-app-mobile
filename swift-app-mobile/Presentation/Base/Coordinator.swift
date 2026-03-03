import SwiftUI

protocol Coordinator: ObservableObject where Screen: Routable {
    associatedtype Screen

    var navigationPath: [Screen] { get set }
}

extension Coordinator {
    func push(_ screen: Screen) {
        navigationPath.append(screen)
    }

    func pop() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }

    func popToRoot() {
        navigationPath.removeAll()
    }
}
