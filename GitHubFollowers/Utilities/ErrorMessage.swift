//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/24.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username is invalid."
    case unableToComplete = "Unable to complete your request."
    case invalidResponse = "Invalid response from the server."
    case invalidData = "Invalid data from the server."
}
