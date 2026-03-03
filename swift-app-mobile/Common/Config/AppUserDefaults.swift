import Foundation

enum AppUserDefaults {
    private enum Keys {
        static let isLoggedIn = "isLoggedIn"
        static let userId = "userId"
        static let userRole = "userRole"
        static let isFreshInstall = "isFreshInstall"
    }

    // MARK: - Auth State

    static var isLoggedIn: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.isLoggedIn) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.isLoggedIn) }
    }

    static var userId: String? {
        get { UserDefaults.standard.string(forKey: Keys.userId) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.userId) }
    }

    static var userRole: String? {
        get { UserDefaults.standard.string(forKey: Keys.userRole) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.userRole) }
    }

    static var isFreshInstall: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.isFreshInstall) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.isFreshInstall) }
    }

    // MARK: - Clear

    static func clearAll() {
        isLoggedIn = false
        userId = nil
        userRole = nil
    }
}
