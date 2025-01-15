//
//  api.swift
//  LoginDemo
//
//  Created by Donie Kelly on 1/15/25.
//

import Foundation

// Define an enum to represent the result of the API call
enum APIResult<T> {
    case success(T)
    case failure(String)
}
