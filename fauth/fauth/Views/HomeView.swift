import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(authModel.user?.email ?? "")")
            }
            .navigationTitle("Home")
            .toolbar {
                Button("Logout") {
                    authModel.logout()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AuthViewModel())
    }
}
