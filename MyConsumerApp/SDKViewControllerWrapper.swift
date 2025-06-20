import SwiftUI
import MyAwesomeSDK

struct SDKViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var users: [User]?
    
    // Optional binding to communicate back to SwiftUI
    init(users: Binding<[User]?> = .constant(nil)) {
        self._users = users
    }
    
    func makeUIViewController(context: Context) -> MyViewController {
        let viewController = MyViewController()
        
        // You can customize the SDK view controller here if needed
        // For example, set up any delegates or callbacks
        
        return viewController
    }

    func updateUIViewController(_ uiViewController: MyViewController, context: Context) {
        // Update the view controller if needed based on SwiftUI state changes
        // This is called when the SwiftUI view updates
    }

    // MARK: - Coordinator for handling callbacks
    class Coordinator: NSObject {
        var parent: SDKViewControllerWrapper
        
        init(_ parent: SDKViewControllerWrapper) {
            self.parent = parent
        }
        
        // Add methods here to handle callbacks from the SDK if needed
        func handleSDKCallback(users: [User]) {
            parent.users = users
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

// MARK: - Preview
#Preview {
    SDKViewControllerWrapper()
        .frame(height: 300)
}
