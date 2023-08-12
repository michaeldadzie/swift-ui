import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                SecureField("Password", text: $password)
                        .keyboardType(.default)
                        .textContentType(.password)
                        .autocapitalization(.none)
                }
                
                Section {
                    Button("Sign Up") {
                        authModel.signUp(email: email, password: password)
                    }
                }
            }
            .navigationTitle("Sign Up")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(AuthViewModel())
    }
}
