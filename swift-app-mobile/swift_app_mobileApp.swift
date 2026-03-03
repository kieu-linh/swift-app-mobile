//
//  swift_app_mobileApp.swift
//  swift-app-mobile
//
//  Created by Kieu Linh on 3/3/26.
//

import SwiftUI

@main
struct swift_app_mobileApp: App {
    private let appFactory = AppFactory()

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(
                screenFactory: ScreenFactory(appFactory: appFactory),
                coordinator: AppCoordinator()
            )
            .onAppear {
                NetworkMonitor.shared.startMonitoring()

                // Clear token on fresh install
                if !AppUserDefaults.isFreshInstall {
                    try? KeychainService.shared.deleteToken()
                    AppUserDefaults.isFreshInstall = true
                }
            }
        }
    }
}
