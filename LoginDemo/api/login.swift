//
//  login.swift
//  LoginDemo
//
//  Created by Donie Kelly on 1/9/25.
//
import Foundation

/**
 * Login API
 */
struct LoginRequest: Codable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let message: String?
    let name: String
    let token: String?
}

struct LoginResult: Codable  {
    let name: String
}

func login(username: String, password: String, completion: @escaping (APIResult<LoginResult>) -> Void) {
    
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
            completion(.failure(error.localizedDescription))
            return
        }

        guard let data = data else { return }
        do {
            
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            if let token = loginResponse.token {
                UserDefaults.standard.set(token, forKey: "token")
            }
            let result = LoginResult(name: loginResponse.name)
            completion(.success(result))

        } catch {
            
            completion(.failure("Error decoding response"))
        }
    }.resume()
}


/**
 * Forgot Password API
 */
struct ForgotPasswordRequest: Codable {
    let username: String
}

struct ForgotPasswordResponse: Codable {
    let message: String
}

struct ForgotPasswordResult: Codable  {
    let message: String
}

func forgotPassword(password: String, completion: @escaping (APIResult<ForgotPasswordResult>) -> Void) {
    
    guard let url = URL(string: "http://127.0.0.1:3001/api/v1/forgot") else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let loginRequest = ForgotPasswordRequest(username: password)
    guard let httpBody = try? JSONEncoder().encode(loginRequest) else { return }
    request.httpBody = httpBody

    let session = URLSession.shared
    session.dataTask(with: request) { data, response, error in

        if let error = error {
            completion(.failure(error.localizedDescription))
            return
        }

        guard let data = data else { return }
        do {
            let forgotResponse = try JSONDecoder().decode(ForgotPasswordResponse.self, from: data)
            let result = ForgotPasswordResult(message: forgotResponse.message)
            completion(.success(result))

        } catch {
            
            completion(.failure("Error decoding response"))
        }
    }.resume()
}
