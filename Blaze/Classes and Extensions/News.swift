//
//  News.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import Foundation
import UIKit

struct News: Comparable, Identifiable, Codable {
    // MARK: - Comparable Protocol Functions
    
    static func < (lhs: News, rhs: News) -> Bool {
        return lhs.date < rhs.date
    }
    
    static func > (lhs: News, rhs: News) -> Bool {
        return lhs.date > rhs.date
    }
    
    // MARK: - Attributes
    
    var id: String /// Title
    var author: String
    var authorImg: String? /// URL to author's profile picture
    var authorBio: String
    var content: String /// Can be markdown / html
    var coverImage: String
    var publisher: String /// News site
    var sourceURL: String /// Direct link to article
    var date: Date
    
    // MARK: - Functions
    
    func getTimeAgo() -> String {
        return date.getElapsedInterval()
    }
    
    func share(_ pos: Int) {
        let actionView = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIApplication.shared.windows[pos].rootViewController?.present(actionView, animated: true, completion: nil)
    }
    
    // MARK: - Computed Properties
    
    var url: URL {
        URL(string: sourceURL) ?? URL(string: "https://inciweb.nwcg.gov/incidents")!
    }
}
