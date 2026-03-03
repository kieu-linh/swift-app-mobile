import SwiftUI

struct HomeView<VM: ViewModel>: View where VM.State == HomeState, VM.Event == HomeEvent {
    @ObservedObject var viewModel: VM

    var body: some View {
        VStack(spacing: AppStyles.paddingLarge) {
            Spacer()

            // Welcome
            VStack(spacing: 12) {
                Image(systemName: "house.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(AppColors.primaryHex)

                Text("Welcome, \(viewModel.state.userName)!")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("You are logged in successfully.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack(spacing: AppStyles.paddingSmall) {
                // Profile button
                Button {
                    viewModel.handle(.navigateToProfile)
                } label: {
                    HStack {
                        Image(systemName: "person.circle")
                        Text("View Profile (Sample UI)")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .fullWidth()
                    .frame(height: AppStyles.buttonHeight)
                    .background(AppColors.primaryHex)
                    .cornerRadius(AppStyles.cornerRadius)
                }

                // Logout button
                Button {
                    viewModel.handle(.logout)
                } label: {
                    HStack {
                        Image(systemName: "arrow.right.square")
                        Text("Sign Out")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .fullWidth()
                    .frame(height: AppStyles.buttonHeight)
                    .background(Color(hex: "#FF3B30"))
                    .cornerRadius(AppStyles.cornerRadius)
                }
            }
            .padding(.horizontal, AppStyles.paddingLarge)
            .padding(.bottom, AppStyles.paddingLarge)
        }
        .navigationTitle("Home")
        .onAppear {
            viewModel.handle(.onAppear)
        }
    }
}
