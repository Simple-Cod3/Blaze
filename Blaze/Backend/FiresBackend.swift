//
//  FiresBackend.swift
//  Blaze
//
//  Created by Nathan Choi on 9/2/20.
//

import Foundation
import SwiftUI

class FireBackend: ObservableObject {
    @Published var fires = [ForestFire]()
    
    init() {}
    
    /// Update the fire catalog
    func refreshFireList() {
        let group = DispatchGroup()
        
        let url = URL(string: "https://www.fire.ca.gov/umbraco/api/IncidentApi/List?inactive=false")!
        print("==== [ Grabbing new fires ] ====")
        
        group.enter()
        URLSession.shared.dataTask(with: url) { unsafeData, reponse, error in
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
                let newFires = try jsonDecoder.decode([ForestFire].self, from: data)
                self.fires = newFires.sorted(by: >)
            } catch {
                print("* JSON Decoding failed: \(error)")
            }
            
            group.leave()
        }.resume()
        
        group.notify(queue: .main) {
            print("Done!")
        }
    }
}
