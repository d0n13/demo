//
//  login.swift
//  LoginDemo
//
//  Created by Donie Kelly on 1/9/25.
//
import Foundation

struct LoginRequest: Codable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let success: Bool
    let message: String?
    let name: String
    let token: String?
}

func login(username: String, password: String, completion: @escaping (LoginResponse?) -> Void) {
    
    guard let url = URL(string: "http://127.0.0.1:3001/api/v1/login") else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let loginRequest = LoginRequest(username: username, password: password)
    guard let httpBody = try? JSONEncoder().encode(loginRequest) else { return }
    request.httpBody = httpBody

    let session = URLSession.shared
    session.dataTask(with: request) { data, response, error in

        if let error = error {
            print("Error: \(error.localizedDescription)")
            completion(nil)
            return
        }

        guard let data = data else { return }
        do {
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            NSLog("response: \(loginResponse)")
            if loginResponse.success {

                if let token = loginResponse.token {
                    UserDefaults.standard.set(token, forKey: "token")
                }
                completion(loginResponse)

            } else {

                print("Login failed: \(loginResponse.message ?? "Login failed")")
                completion(nil)
            }
        } catch {
            
            print("Error decoding response: \(error.localizedDescription)")
            completion(nil)
        }
    }.resume()
}

struct ForgotPasswordResponse: Codable {
    let success: Bool
    let message: String?
}

func forgotPassword(password: String, completion: @escaping (ForgotPasswordResponse?) -> Void) {
    
    guard let url = URL(string: "http://127.0.0.1:3001/api/v1/forgot") else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    
    if let token = UserDefaults.standard.string(forKey: "token") {
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    
}
