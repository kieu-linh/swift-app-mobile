import SwiftUI

enum L10n {
    // MARK: - Common
    enum Common {
        static let appName = "app_name".localized
        static let ok = "common_ok".localized
        static let cancel = "common_cancel".localized
        static let done = "common_done".localized
        static let save = "common_save".localized
        static let delete = "common_delete".localized
        static let edit = "common_edit".localized
        static let close = "common_close".localized
        static let back = "common_back".localized
        static let next = "common_next".localized
        static let retry = "common_retry".localized
        static let loading = "common_loading".localized
        static let search = "common_search".localized
    }

    // MARK: - Auth
    enum Auth {
        static let login = "auth_login".localized
        static let logout = "auth_logout".localized
        static let register = "auth_register".localized
        static let email = "auth_email".localized
        static let password = "auth_password".localized
        static let forgotPassword = "auth_forgot_password".localized
        static let welcomeBack = "auth_welcome_back".localized
        static let signInContinue = "auth_sign_in_continue".localized
        static let enterEmail = "auth_enter_email".localized
        static let enterPassword = "auth_enter_password".localized
        static let noAccount = "auth_no_account".localized
        static let signUp = "auth_sign_up".localized
    }

    // MARK: - Home
    enum Home {
        static let title = "home_title".localized
        static let welcome = "home_welcome".localized
    }

    // MARK: - Profile
    enum Profile {
        static let title = "profile_title".localized
        static let editProfile = "profile_edit".localized
        static let settings = "profile_settings".localized
    }

    // MARK: - Error
    enum Error {
        static let general = "error_general".localized
        static let network = "error_network".localized
        static let unauthorized = "error_unauthorized".localized
        static let serverError = "error_server".localized
    }

    // MARK: - Success
    enum Success {
        static let loginSuccess = "success_login".localized
        static let registerSuccess = "success_register".localized
    }
}

// MARK: - String Extension for Localization

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }

    func localized(with arguments: CVarArg...) -> String {
        String(format: self.localized, arguments: arguments)
    }
}
