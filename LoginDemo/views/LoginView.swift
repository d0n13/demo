//
//  ContentView.swift
//  LoginDemo
//
//  Created by Donie Kelly on 1/8/25.
//

import SwiftUI

class VersionViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var serverVersion: String = ""

    // Get the server verison
    func fetchVersion() {
        
        isLoading = true
        getServerVersion { versionResult in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                
                switch(versionResult) {
                    
                case .success(let result):
                    self.serverVersion = result.version

                case .failure(_):
                    self.serverVersion = "*.*.*"
                }
            }
        }
    }
}

class LoginViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var loginName: String = ""
    
    func doLogin(username: String, password: String, completion: @escaping() -> Void  ) {
        
        isLoading = true
        // Handle login action here
        login(username: username, password: password) { loginResult in
            
            DispatchQueue.main.async {
                
                switch(loginResult) {
                case .success(let result):
                    self.isLoggedIn = true
                    self.loginName = result.name
                    completion()
                case .failure(let error):
                    self.isLoggedIn = false
                    print (error)
                    completion()
                }
                self.isLoading = false
            }
        }
    }
}

struct LoginView: View {
    
    @State public var user: String = "donie@gmail.com"
    @State public var pass: String = "donie"
    
    @StateObject private var versionViewModel = VersionViewModel()
    @StateObject private var loginViewModel = LoginViewModel()
    
    
    var body: some View {
        
        NavigationStack() {
            
            ZStack {
                Background()
                
                if versionViewModel.isLoading {
                    
                    ProgressView("Loading...")
                    
                } else {
                    
                    ScrollView {
                        
                        Logo()
                        UserNameField(email: user)
                        PasswordField(password: pass)
                            
                        Button {
                            loginViewModel.doLogin(username: user, password: pass) {
                                if loginViewModel.isLoggedIn {
                                    print("logged in")
                                }
                            }
                            
                        } label: {
                            LoginButton(name: "Login")
                        }
                        
                        ForgotPassword()
                        
                        RightTextView(text: versionViewModel.serverVersion)
                    }
                    .navigationTitle("Account Login")
                    .navigationBarTitleDisplayMode(.inline)
                }
                
                    
            }
            .onAppear {
                versionViewModel.fetchVersion()
            }
        }
    }
}

#Preview {
    LoginView()
}


