//
//  ForgotView.swift
//  LoginDemo
//
//  Created by Donie Kelly on 1/13/25.
//

import SwiftUI

struct ForgotView: View {
    @State private var username: String = "donie1234"
    @State private var password: String = "donie1234"
    @State private var isLoggingIn: Bool = false
    
    var body: some View {
            
            ScrollView {
                
                Image("logo") // Replace with your logo asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .shadow(radius: 10)
                
                Text("Enter you new password")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding()
                
                // Password SecureField
                SecureField("New Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                
                
                // Password SecureField
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                
                
                Button(action: {
                    withAnimation(.easeIn(duration: 1)){
                        isLoggingIn = true
                    }
                    // Handle login action here
                    forgotPassword(password: password) { loginResponse in
                        
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
                
            }
            .navigationTitle("Forgot Password")
            .navigationBarTitleDisplayMode(.inline)
        }
}

#Preview {
    ForgotView()
}
