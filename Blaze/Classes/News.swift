//
//  News.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import Foundation

/// News data structure
struct News: Comparable {
    static func < (lhs: News, rhs: News) -> Bool {
        return lhs.date < rhs.date;
    }
    
    static func > (lhs: News, rhs: News) -> Bool {
        return lhs.date > rhs.date;
    }
    
    var id: String /// Title
    var author: String
    var authorImg: String? /// URL to author's profile picture
    var authorBio: String
    var content: String /// Can be markdown / html
    var coverImage: String
    var publisher: String /// News site
    var sourceURL: String /// Direct link to article
    var date: Date
    
    func getTimeAgo() -> String {
        return date.timeAgo()
    }
}
