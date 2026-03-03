import SwiftUI

// MARK: - Sample UI demonstrating Common layer usage

struct ProfileView: View {
    @State private var name = "Kieu Linh"
    @State private var email = "linh@example.com"
    @State private var joinDate = "2026-03-03T10:00:00.000Z"
    @State private var showLogoutAlert = false

    var body: some View {
        ScrollView {
            VStack(spacing: AppStyles.paddingLarge) {

                // ── Avatar Section ──
                // Uses: AppColors (hex), AppStyles (sizing)
                avatarSection

                // ── Info Cards ──
                // Uses: Color+Extension (hex init), View+Extension (fullWidth)
                infoSection

                // ── Stats Row ──
                // Uses: AppColors, AppStyles (cornerRadius, padding)
                statsSection

                // ── Color Palette Demo ──
                // Uses: Color+Extension (hex), AppColors
                colorPaletteSection

                // ── Action Buttons ──
                // Uses: AppStyles (buttonHeight, cornerRadius), AppColors
                actionSection
            }
            .padding(.horizontal, AppStyles.paddingLarge)
            .padding(.top, AppStyles.paddingMedium)
        }
        .background(Color(hex: "#F5F5F5"))
        .navigationTitle("Profile")
        .onTapDismissKeyboard() // View+Extension
        .alert("Sign Out", isPresented: $showLogoutAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Sign Out", role: .destructive) {}
        } message: {
            Text("Are you sure you want to sign out?")
        }
    }
}

// MARK: - Subviews

private extension ProfileView {

    // ── Avatar ──
    var avatarSection: some View {
        VStack(spacing: AppStyles.paddingSmall) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "#007AFF"), Color(hex: "#5856D6")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)

                Text(name.prefix(1).uppercased())
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
            }

            Text(name)
                .font(.title2)
                .fontWeight(.bold)

            Text(email)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Uses: String+Extension (.toDate + Date.toString)
            if let date = joinDate.toDate() {
                Text("Joined \(date.toString(format: "MMM dd, yyyy"))")
                    .font(.caption)
                    .foregroundColor(Color(hex: "#8E8E93"))
            }
        }
        .padding(.vertical, AppStyles.paddingMedium)
    }

    // ── Info Cards ──
    var infoSection: some View {
        VStack(spacing: AppStyles.paddingSmall) {
            infoRow(icon: "person.fill", title: "Full Name", value: name)
            infoRow(icon: "envelope.fill", title: "Email", value: email)
            infoRow(icon: "phone.fill", title: "Phone", value: "+84 123 456 789")
            infoRow(icon: "mappin.circle.fill", title: "Location", value: "Ho Chi Minh City")
        }
        .padding(AppStyles.paddingMedium)
        .background(Color.white)
        .cornerRadius(AppStyles.cornerRadius)
        .shadow(color: Color.black.opacity(0.05), radius: 8, y: 4)
    }

    func infoRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: AppStyles.paddingSmall) {
            Image(systemName: icon)
                .frame(width: AppStyles.iconSize, height: AppStyles.iconSize)
                .foregroundColor(AppColors.primaryHex)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: AppFontSize.caption))
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.system(size: AppFontSize.body))
            }

            Spacer()
        }
        .padding(.vertical, AppStyles.paddingSmall / 2)
    }

    // ── Stats ──
    var statsSection: some View {
        HStack(spacing: AppStyles.paddingSmall) {
            statCard(value: "128", label: "Posts", color: "#007AFF")
            statCard(value: "1.2K", label: "Followers", color: "#34C759")
            statCard(value: "256", label: "Following", color: "#FF9500")
        }
    }

    func statCard(value: String, label: String, color: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: AppFontSize.title3, weight: .bold))
                .foregroundColor(Color(hex: color)) // Color+Extension

            Text(label)
                .font(.system(size: AppFontSize.caption))
                .foregroundColor(.secondary)
        }
        .fullWidth() // View+Extension
        .padding(.vertical, AppStyles.paddingMedium)
        .background(Color.white)
        .cornerRadius(AppStyles.cornerRadius)
        .shadow(color: Color.black.opacity(0.05), radius: 8, y: 4)
    }

    // ── Color Palette Demo ──
    var colorPaletteSection: some View {
        VStack(alignment: .leading, spacing: AppStyles.paddingSmall) {
            Text("App Color Palette")
                .font(.system(size: AppFontSize.subheadline, weight: .semibold))

            // Uses: Color+Extension for all hex colors
            HStack(spacing: 8) {
                colorChip(hex: "#007AFF", name: "Primary")
                colorChip(hex: "#5856D6", name: "Purple")
                colorChip(hex: "#34C759", name: "Green")
                colorChip(hex: "#FF9500", name: "Orange")
                colorChip(hex: "#FF3B30", name: "Red")
            }
        }
        .fullWidth() // View+Extension
        .padding(AppStyles.paddingMedium)
        .background(Color.white)
        .cornerRadius(AppStyles.cornerRadius)
        .shadow(color: Color.black.opacity(0.05), radius: 8, y: 4)
    }

    func colorChip(hex: String, name: String) -> some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: hex)) // Color+Extension
                .frame(height: 40)

            Text(name)
                .font(.system(size: AppFontSize.caption2))
                .foregroundColor(.secondary)
        }
    }

    // ── Action Buttons ──
    var actionSection: some View {
        VStack(spacing: AppStyles.paddingSmall) {
            // Primary button style
            Button {
                // Edit profile action
            } label: {
                HStack {
                    Image(systemName: "pencil")
                    Text("Edit Profile")
                }
                .font(.headline)
                .foregroundColor(.white)
                .fullWidth() // View+Extension
                .frame(height: AppStyles.buttonHeight) // AppStyles
                .background(AppColors.primaryHex) // AppColors
                .cornerRadius(AppStyles.cornerRadius) // AppStyles
            }

            // Outline button style
            Button {
                // Settings action
            } label: {
                HStack {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .font(.headline)
                .foregroundColor(AppColors.primaryHex) // AppColors
                .fullWidth() // View+Extension
                .frame(height: AppStyles.buttonHeight)
                .background(Color.white)
                .cornerRadius(AppStyles.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: AppStyles.cornerRadius)
                        .stroke(AppColors.primaryHex, lineWidth: 1.5)
                )
            }

            // Destructive button
            Button {
                showLogoutAlert = true
            } label: {
                HStack {
                    Image(systemName: "arrow.right.square")
                    Text("Sign Out")
                }
                .font(.headline)
                .foregroundColor(.white)
                .fullWidth()
                .frame(height: AppStyles.buttonHeight)
                .background(Color(hex: "#FF3B30")) // Color+Extension
                .cornerRadius(AppStyles.cornerRadius)
            }
        }
        .padding(.bottom, AppStyles.paddingXLarge)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ProfileView()
    }
}
