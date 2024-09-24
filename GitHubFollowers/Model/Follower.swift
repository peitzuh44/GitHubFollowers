//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/24.
//

import Foundation

struct Follower: Codable {
    var login: String
    var avatarUrl: String // Having the exact same name with camel case will be fine
    
}
