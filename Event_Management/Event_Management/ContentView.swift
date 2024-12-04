import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    // Interactive background - to track the drag gesture
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        ZStack {
            // Solid Light Blue Background
            Color.blue.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
                // Email Text Field
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                        .foregroundColor(.black)
                    TextField("Enter your email", text: $email)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }
                .padding(.horizontal)
                
                // Password Text Field
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(.headline)
                        .foregroundColor(.black)
                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                }
                .padding(.horizontal)
                
                // Error Message Display
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .bold()
                        .padding(.top, 5)
                        .transition(.opacity)
                }
                
                // Sign-up Button
                Button(action: register) {
                    HStack {
                        Text("Sign Up")
                            .bold()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(15)
                            .shadow(radius: 8)
                            .scaleEffect(isLoading ? 0.95 : 1.0) // Adding animation when clicked
                            .opacity(isLoading ? 0.7 : 1.0)  // Slight opacity when loading
                    }
                }
                .padding(.horizontal)
                .disabled(isLoading) // Disable button when loading
                
                // Log-in Button
                Button(action: login) {
                    HStack {
                        Text("Log In")
                            .bold()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(15)
                            .shadow(radius: 8)
                            .scaleEffect(isLoading ? 0.95 : 1.0)
                            .opacity(isLoading ? 0.7 : 1.0)  // Slight opacity when loading
                    }
                }
                .padding(.horizontal)
                .disabled(isLoading)
                
                // Loading Indicator
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                        .padding(.top, 20)
                }
            }
            .padding(.top)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 10)
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    // Register Function
        func register() {
            isLoading = true
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.errorMessage = "Registration successful!"
                    self.email = ""
                    self.password = ""
                }
            }
        }

    
    // Login Function
        func login() {
            isLoading = true
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.errorMessage = "Login successful!"
                    userIsLoggedIn = true
                }
            }
        }
    }
#Preview {
    ContentView()
}
