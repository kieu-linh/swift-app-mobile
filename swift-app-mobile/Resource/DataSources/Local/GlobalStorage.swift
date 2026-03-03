import Foundation

final class GlobalStorage {
    static let shared = GlobalStorage()

    var user: UserEntity?

    private init() {}

    func clear() {
        user = nil
    }
}
