import SwiftUI

// behind this is UI hosting controller
// bridge between UIKit and SwiftUI
struct ContentView: View {
    @State private var useRedText = false
    // opaque return type
    var body: some View {
        Text("UTOPIA")
            .padding()
            .foregroundColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
