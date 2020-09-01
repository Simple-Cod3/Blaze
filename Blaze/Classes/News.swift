//
//  News.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import Foundation

/// News data structure
struct News {
    var id: String /// Title
    var author: String
    var authorImg: String /// URL to author's profile picture
    var authorBio: String
    var content: String /// Can be markdown / html
    var coverImage: String
    var publisher: String /// News site
    var sourceURL: String /// Direct link to article
    var date: String
    
    func getTimeAgo() -> String {
        return "1 hour ago"
    }
}
