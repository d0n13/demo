//
//  Views.swift
//  LoginDemo
//
//  Created by Donie Kelly on 1/15/25.
//

import SwiftUI

struct Background: View {
    
    var body: some View {
        
        ContainerRelativeShape()
            .fill(Color.blue.gradient)
            .ignoresSafeArea()
    }
}

struct Logo: View {
    
    var body: some View {
        
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .shadow(radius: 20, x: 10, y: 10)
            .cornerRadius(15)
            .padding(40)
    }
}

struct UserNameField: View {
    
    @State var email: String = "Login"
    
    var body: some View {
        
        TextField("Username", text: $email)
            .padding()
            .keyboardType(.emailAddress)
            .foregroundStyle(.primary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .padding(.horizontal, 30)
    }
}

struct PasswordField: View {
    
    @State var password: String = "Login"
    
    var body: some View {
        
        SecureField("Password", text: $password)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .padding(.horizontal, 30)
    }
}


struct LoginButton: View {
    
    @StateObject private var loginViewModel = LoginViewModel()
    
    var name: String = "Login"
    
    var body: some View {
        Text(name)
            .font(.headline)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.mint)
            .cornerRadius(10)
            .padding(.horizontal, 30)
            .shadow(radius: 10)
            .padding(.vertical)
    }
}

struct ForgotPassword: View {
    
    var name: String = "Forgot Password"
    
    var body: some View {
        NavigationLink(destination: ForgotView()) {
            Text(name)
                .underline(color: .init(red: 0, green: 0, blue: 0, opacity: 0.5))
                .foregroundColor(.primary)
                .padding(.vertical)
        }
    }
}


struct BoldTextView: View {
    
    var text: String = ""
    
    var body: some View {
        Text(text)
            .font(.body)
            .fontWeight(.bold)
            .padding()
    }
}

struct RightTextView: View {
    
    var text: String = ""
    
    var body: some View {
        
        Text(text)
            .font(.footnote)
            .fontWeight(.light)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 10, alignment: .bottomTrailing)
    }
}
