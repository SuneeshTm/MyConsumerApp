import SwiftUI
import MyAwesomeSDK

struct SDKViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> MyViewController {
        return MyViewController()
    }

    func updateUIViewController(_ uiViewController: MyViewController, context: Context) {
        // Leave empty if no dynamic updates needed
    }

    // MARK: - Required Coordinator
    class Coordinator {}

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}
#Preview {
    SDKViewControllerWrapper()
}