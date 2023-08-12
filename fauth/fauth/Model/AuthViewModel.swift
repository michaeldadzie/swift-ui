import FirebaseAuth
import SwiftUI

final class AuthViewModel: ObservableObject {
    var user: User? {
        didSet {
            objectWillChange.send()
        }
    }
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            self.user = user
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("an error occured: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func signin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error = error {
                print("an error occured: \(error.localizedDescription)")
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError as NSError {
            print("Error loggin out: %@", logoutError)
        }
    }
}
