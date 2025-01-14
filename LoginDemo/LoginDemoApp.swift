//
//  LoginDemoApp.swift
//  LoginDemo
//
//  Created by Donie Kelly on 1/8/25.
//

import SwiftUI

//class HostingController<Content: View>: UIHostingController<Content> {
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent // Set the status bar to dark content
//    }
//}

@main
struct LoginDemoApp: App {
    var body: some Scene {
        WindowGroup {
//            HostingControllerWrapper {
                LoginView()
//            }
        }
    }
}
 
// Helper struct to wrap the Hosting Controller
//struct HostingControllerWrapper<Content: View>: UIViewControllerRepresentable {
//    let content: Content
//
//    init(@ViewBuilder content: () -> Content) {
//        self.content = content()
//    }
//
//    func makeUIViewController(context: Context) -> HostingController<Content> {
//        HostingController(rootView: content)
//    }
//
//    func updateUIViewController(_ uiViewController: HostingController<Content>, context: Context) {
//        // No need to update anything here
//    }
//}
