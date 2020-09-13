//
//  FiresBackend.swift
//  Blaze
//
//  Created by Nathan Choi on 9/2/20.
//

import Foundation
import SwiftUI

/// Manages the fires behinds the scenes and updates UI accordingly
class FireBackend: ObservableObject {
    @Published var loading = true
    @Published var fires = [ForestFire]()
    
    var progress = Progress()

    init(fires: [ForestFire]? = nil) {
        if let fires = fires {
            self.fires = fires
        }
    }

    func refreshFireList(with: URL? = nil) {
        self.loading = true
        let group = DispatchGroup()
        
        let url = with ?? URL(string: "https://www.fire.ca.gov/umbraco/Api/IncidentApi/GetIncidents")!
        print("==== [ Grabbing new fires ] ====")
        
        let task = URLSession.shared.dataTask(with: url) { unsafeData, reponse, error in
            guard let data: Data = unsafeData else {
                print("* No data found")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategyFormatters = [
                DateFormatter.iso8601Full,
                DateFormatter.iso8601,
                DateFormatter.iso8601NoExtention,
            ]
            
            do {
                let newFires = try jsonDecoder.decode(Incidents.self, from: data)
                self.fires = newFires.incidents.sorted(by: ForestFire.dateUpdated)
            } catch {
                print("* JSON Decoding failed: \(error)")
            }
            
            group.leave()
        }
        
        self.progress = task.progress
        
        group.enter()
        task.resume()
        
        /// When all tasks are finished
        group.notify(queue: .main) {
            self.loading = false
            print(" ** Done!")
        }
    }
}
