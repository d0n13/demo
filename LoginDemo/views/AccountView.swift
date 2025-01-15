//
//  AccountView.swift
//  LoginDemo
//
//  Created by Donie Kelly on 1/15/25.
//

import SwiftUI

struct AccountView: View {
    
    var name:String
    
    var body: some View {
        NavigationStack() {
            
            ZStack {
                Background()
                
                ScrollView {
                        
                    Logo()
                    Button {} label: {
                        LoginButton(name: "Back")
                    }
                }
            }
        }
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AccountView(name: "Donie Kelly")
}
