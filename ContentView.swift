import SwiftUI

struct ContentView: View {
    var body: some View {
        ItemsView()
            .overlay {
                Text("Built App")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.orange)
                    .opacity(0.3)
                    .shadow(radius: 2)
            }
    }
}
