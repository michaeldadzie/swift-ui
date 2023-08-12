import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    
    var body: some View {
        Group {
            if authModel.user != nil {
                HomeView()
            } else {
                SignUpView()
            }
        } .onAppear(perform: authModel.listenToAuthState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthViewModel())
    }
}
