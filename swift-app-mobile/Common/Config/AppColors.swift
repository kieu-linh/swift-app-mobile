import SwiftUI

enum AppColors {
    static let primary = Color("PrimaryColor")
    static let secondary = Color("SecondaryColor")
    static let background = Color("BackgroundColor")
    static let surface = Color("SurfaceColor")
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary
    static let error = Color.red
    static let success = Color.green
    static let warning = Color.orange

    // Fallback hex colors
    static let primaryHex = Color(hex: "#007AFF")
    static let darkBackground = Color(hex: "#1C1C1E")
    static let lightBackground = Color(hex: "#F2F2F7")
    static let separator = Color(hex: "#C6C6C8")
}
