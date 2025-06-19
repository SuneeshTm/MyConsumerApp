import SwiftUI
import MyAwesomeSDK

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Consumer App")
                .font(.title)
            
            SDKViewControllerWrapper()
                .frame(height: 300)
                .padding()
        }
    }
}
#Preview {
    ContentView()
}