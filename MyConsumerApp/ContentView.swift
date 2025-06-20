import SwiftUI
import MyAwesomeSDK

struct ContentView: View {
    @State private var users: [User] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Consumer App")
                        .font(.title)
                        .padding()
                    
                    // SDK ViewController Integration
                    SDKViewControllerWrapper()
                        .frame(height: 300)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    // SDK API Integration
                    VStack(spacing: 15) {
                        Text("SDK API Integration")
                            .font(.headline)
                        
                        Button("Fetch Users from SDK") {
                            fetchUsersFromSDK()
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(isLoading)
                        
                        if isLoading {
                            ProgressView("Loading users...")
                                .padding()
                        }
                        
                        if let errorMessage = errorMessage {
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                                .padding()
                        }
                        
                        // Scrollable Users List
                        if !users.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Fetched \(users.count) users")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                
                                // Option 1: LazyVStack for better performance with many items
                                LazyVStack(spacing: 12) {
                                    ForEach(users, id: \.id) { user in
                                        UserCard(user: user)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("My Consumer App")
            .refreshable {
                fetchUsersFromSDK()
            }
        }
    }
    
    private func fetchUsersFromSDK() {
        isLoading = true
        errorMessage = nil
        
        let sdk = MyAwesomeSDKCore()
        sdk.getAllUsers { result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let fetchedUsers):
                    users = fetchedUsers
                    print("Successfully fetched \(fetchedUsers.count) users from SDK")
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    print("Error fetching users: \(error)")
                }
            }
        }
    }
}

// MARK: - User Card Component
struct UserCard: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            // Avatar
            Circle()
                .fill(LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 50, height: 50)
                .overlay(
                    Text(String(user.name.prefix(1)))
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                )
            
            // User Info
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("User ID: \(user.id)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Chevron indicator
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

