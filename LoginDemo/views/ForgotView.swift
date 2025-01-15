//
//  ForgotView.swift
//  LoginDemo
//
//  Created by Donie Kelly on 1/13/25.
//

import SwiftUI

class ForgotPasswordViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isChanged: Bool = false
    
    func doForgotPassword(password: String, completion: @escaping(Bool) -> Void  ) {
        
        isLoading = true
        forgotPassword(password: password, completion: { result in
            DispatchQueue.main.async {
                
                self.isLoading = false
                
                switch result {
                case .success(let message):
                    self.isChanged = true
                    completion(true)
                case .failure(let error):
                    self.isChanged = false
                    completion(false)
                }
            }
        })
    }
}

struct ForgotView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var password: String = "donie"
    
    @StateObject private var forgotViewModel = ForgotPasswordViewModel()
    
    var body: some View {
            
        NavigationStack() {
            
            ZStack {
                Background()
                ScrollView {
                    Logo()
                    BoldTextView(text: "Enter you new password")
                    PasswordField(password: password)
                    PasswordField(password: password)
                    
                    Button {
                        if password.count > 1 {
                            forgotViewModel.doForgotPassword(password: password, completion: { changed in
                                
                                if changed {
                                    dismiss()
                                }
                            })
                        }
                        
                    } label: {
                        LoginButton(name: "Change Password")
                    }
                }
            }
            .navigationTitle("Change Password")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ForgotView()
}
