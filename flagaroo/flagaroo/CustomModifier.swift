import SwiftUI

struct Header: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        content
        Text(text)
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

extension View {
    func header(with text: String) -> some View {
        modifier(Header(text: text))
    }
}
