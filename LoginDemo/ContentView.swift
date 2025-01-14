//
//  ContentView.swift
//  LoginDemo
//
//  Created by Donie Kelly on 1/8/25.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = "donie.kelly@gmail.com"
    @State private var password: String = "donie123"
    @State private var isLoggingIn: Bool = false

    var body: some View {
        
        NavigationSplitView {
                
                ScrollView {
                    
                    // Logo
                    Image("logo") // Replace with your logo asset name
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .shadow(radius: 10)
                    
                    // Username TextField
                    TextField("Username", text: $username)
                        .padding()
                        .keyboardType(.emailAddress)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    
                    // Password SecureField
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    
                    // Login Button
                    Button(action: {
                        withAnimation(.easeIn(duration: 1)){
                            isLoggingIn = true
                        }
                        // Handle login action here
                        login(username: username, password: password) { loginResponse in
                            
                            NSLog("response: \(String(describing: loginResponse))")
                            
                            getVersion { version in
                                NSLog("version: \(String(describing: version))")
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeIn(duration: 1)) {
                                isLoggingIn = false
                            }
                        }
                    }) {
                        Text(isLoggingIn ? "Logging In..." : "Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isLoggingIn ? Color.red : Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                            .shadow(radius: 10)
                    }
                    .disabled(isLoggingIn)
                    
                    Spacer(minLength: 12)
                    
                    NavigationLink(destination: ForgotView()) {
                        Text("Forgot Password")
                            .underline(color: .init(red: 0, green: 0, blue: 0, opacity: 0.5))
                            .foregroundColor(.primary)
                    }
                }
                .navigationTitle("Login")
                .navigationBarTitleDisplayMode(.inline)
        }
        detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    LoginView()
}
