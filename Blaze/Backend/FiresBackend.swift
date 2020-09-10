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
    // MARK: - Published States
    
    @Published var fires = [ForestFire]()
    
    // MARK: - Init Function
    /**
     You actually don't need any parameters to initialize this object
     
     - Parameters:
        - fires: Optional argument to initialize fires list on initilization of the object
     
     - Returns:
        - A fast, amazing, and clean `FireBackend`
     */
    init(fires: [ForestFire]? = nil) {
        if let fires = fires {
            self.fires = fires
        }
    }
    // MARK: - Functions
    
    /**
     Update the fire database from the `https://fire.ca.gov API`
     
     - Important:
        Try not to spam the function. For example:
     
            let fireBackend = FireBackend()
            while true {
                fireBackend.refreshList()
            }
     
     */
    func refreshFireList(with: URL? = nil) {
        let group = DispatchGroup()
        
        let url = with ?? URL(string: "https://www.fire.ca.gov/umbraco/Api/IncidentApi/GetIncidents")!
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
                let newFires = try jsonDecoder.decode(Incidents.self, from: data)
                self.fires = newFires.incidents.sorted(by: ForestFire.dateUpdated)
            } catch {
                print("* JSON Decoding failed: \(error)")
            }
            
            group.leave()
        }.resume()
        
        // TODO: Create secondary data source from inicweb
        let url2 = URL(string: "https://inciweb.nwcg.gov/feeds/json/esri/")!
        
        group.notify(queue: .main) {
            print("Done!")
        }
    }
}
