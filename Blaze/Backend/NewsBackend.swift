//
//  NewsBackend.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import Foundation
import FeedKit

class NewsBackend: ObservableObject {
    /// Stores `News` objects
    @Published var newsList = [News]()
    @Published var loaded = false
    @Published var progress = Progress()
    
    func createTestCases() {
        loaded = true
        let news1 = News(id: "Shasta-Trinity NF Elkhorn and Hopkins Fire Closure (Elkhorn Fire Wildfire).",
                         author: "Paul Wong",
                         authorImg: "https://assets3.thrillist.com/v1/image/2855068/1200x630",
                         authorBio: "Is an anime lover",
                         content: "Shasta-Trinity National Forest Closure Order No. 14-20-08 is in effect for the area of the Elkhorn and Hopkins Fire. Shasta-Trinity National Forest officials have issued a Forest Closure Order for the area of the Elkhorn and Hopkins Fire areas which are burning in and near the Yolla Bolly-Middle Eel Wilderness on the South Fork Management Unit. This closure order closes the portion of the Shasta-Trinity National Forest west of Forest Road 30 and south of Forest Roads 28N23 (Devil’s Camp), 28N10 (Stuart Gap), 28N47 (Retrap), 28N36 (Post Creek) and 28N05 (Wells Creek Peak). Stuart Gap, West Low Gap, Rat Trap Gap, East Low Gap, and Tomhead Saddle Trailheads are closed, as well as Tomhead Saddle Campground.The closure order No. 14-20-08 prohibits public entry to the closure area, its roads and trails. It supersedes 14-20-07 and is effective now until the Elkhorn and Hopkins Fires are declared out.",
                         coverImage: "https://foresttech.events/wp-content/uploads/2017/08/Fire-Image3-1-864x486.jpg",
                         publisher: "Incident Information System",
                         sourceURL: "http://inciweb.nwcg.gov/incident/article/7071/54633/",
                         date: Date(timeIntervalSinceNow: 100))
        
        let news2 = News(id: "Nobody knows where Nathan is going tomorrow.",
                         author: "Nathan Choi",
                         authorImg: "https://assets3.thrillist.com/v1/image/2855068/1200x630",
                         authorBio: "Cool developer",
                         content: "# Markdown Support\n---\n * Yessir\n\n<p style='color: orange'>HTML Support</p>",
                         coverImage: "https://foresttech.events/wp-content/uploads/2017/08/Fire-Image3-1-864x486.jpg",
                         publisher: "NBC News",
                         sourceURL: "https://quick-mass.netlify.app",
                         date: Date(timeIntervalSinceNow: 100))
        
        self.newsList = [news1, news2, news1, news2]
        self.loaded = true
    }
    
    /// self-explanatory
    func refreshNewsList() {
        let start = Date()
        
        self.loaded = false
        print("📰 [ Grabbing News ]")
        
        /// Load news content
        var newNews = [News]()
        let group = DispatchGroup()
        let feedURL = URL(string: "https://inciweb.nwcg.gov/feeds/rss/articles/")!
        
        let task = URLSession.shared.dataTask(with: feedURL) { data, response, error in
            guard let data: Data = data else {
                print("🚫 No news data found")
                return
            }
            
            let parser = FeedParser(data: data)
            parser.parseAsync(queue: .global(qos: .userInitiated)) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let feed):
                        if let items = feed.rssFeed?.items {
                            for item in items {
                                /// Check if the date exists and its a day ago
                                if let date = item.pubDate {
                                    if date.timeIntervalSinceNow > -86400 {
                                        let news = News(
                                            id: item.title ?? "Forest Fire",
                                            author: "Inciweb",
                                            authorBio: "Latest incident updates nationally",
                                            content: item.description ?? "<p style='text-align: center'>No Description</p>",
                                            coverImage: "https://foresttech.events/wp-content/uploads/2017/08/Fire-Image3-1-864x486.jpg",
                                            publisher: "InciWeb National Incidents",
                                            sourceURL: item.link?.replacingOccurrences(of: "http://", with: "https://") ?? "",
                                            date: date)
                                        
                                        /// Push to temp
                                        newNews.append(news)
                                    }
                                }
                            }
                        }
                            
                    case .failure(let error):
                        print("🚫 Couldn't get news: \(error)")
                    }
                    group.leave()
                }
            }
        }
        
        self.progress = task.progress
        
        group.enter()
        task.resume()
        
        group.notify(queue: .main) {
            self.newsList = newNews.sorted(by: >)
            self.loaded = true
            print("✅ Done grabbing news! (\(round(1000.0 * Date().timeIntervalSince(start)) / 1000.0))")
        }
    }
}
