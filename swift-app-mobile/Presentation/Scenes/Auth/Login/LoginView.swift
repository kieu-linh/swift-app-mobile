import SwiftUI

struct LoginView<VM: ViewModel>: View where VM.State == LoginState, VM.Event == LoginEvent {
    @ObservedObject var viewModel: VM

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: AppStyles.paddingLarge) {
                    // Logo
                    headerView

                    // Form
                    VStack(spacing: AppStyles.paddingMedium) {
                        usernameField
                        passwordField
                    }

                    // Error message
                    if let error = viewModel.state.errorMessage {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }

                    // Login button
                    loginButton

                    // Forgot password
                    forgotPasswordButton

                    Spacer()

                    // Register
                    registerButton
                }
                .padding(.horizontal, AppStyles.paddingLarge)
                .padding(.top, 60)
            }
            .onTapDismissKeyboard()

            if viewModel.state.isLoading {
                loadingOverlay
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Subviews

private extension LoginView {
    var headerView: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(AppColors.primaryHex)

            Text("Welcome Back")
                .font(.title)
                .fontWeight(.bold)

            Text("Sign in to continue")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.bottom, AppStyles.paddingMedium)
    }

    var usernameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Email")
                .font(.subheadline)
                .fontWeight(.medium)

            TextField("Enter your email", text: Binding(
                get: { viewModel.state.username },
                set: { viewModel.handle(.updateUsername($0)) }
            ))
            .textFieldStyle(.plain)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(AppStyles.cornerRadius)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
        }
    }

    var passwordField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Password")
                .font(.subheadline)
                .fontWeight(.medium)

            HStack {
                Group {
                    if viewModel.state.showPassword {
                        TextField("Enter your password", text: Binding(
                            get: { viewModel.state.password },
                            set: { viewModel.handle(.updatePassword($0)) }
                        ))
                    } else {
                        SecureField("Enter your password", text: Binding(
                            get: { viewModel.state.password },
                            set: { viewModel.handle(.updatePassword($0)) }
                        ))
                    }
                }
                .textFieldStyle(.plain)
                .textContentType(.password)

                Button {
                    viewModel.handle(.toggleShowPassword)
                } label: {
                    Image(systemName: viewModel.state.showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(AppStyles.cornerRadius)
        }
    }

    var loginButton: some View {
        Button {
            viewModel.handle(.login)
        } label: {
            Text("Sign In")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: AppStyles.buttonHeight)
                .background(viewModel.state.isFormValid ? AppColors.primaryHex : Color.gray)
                .cornerRadius(AppStyles.cornerRadius)
        }
        .disabled(!viewModel.state.isFormValid || viewModel.state.isLoading)
    }

    var forgotPasswordButton: some View {
        Button {
            viewModel.handle(.navigateToForgotPassword)
        } label: {
            Text("Forgot Password?")
                .font(.subheadline)
                .foregroundColor(AppColors.primaryHex)
        }
    }

    var registerButton: some View {
        HStack {
            Text("Don't have an account?")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Button {
                viewModel.handle(.navigateToRegister)
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(AppColors.primaryHex)
            }
        }
        .padding(.bottom, AppStyles.paddingLarge)
    }

    var loadingOverlay: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            ProgressView()
                .scaleEffect(1.5)
                .tint(.white)
        }
    }
}
