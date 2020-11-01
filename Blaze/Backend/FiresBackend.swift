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
    // MARK: - Attributes

    @Published var fires = [ForestFire]()
    @Published var failed = false
    @Published var progress = [Progress(), Progress()]

    // MARK: - Init Function

    init(fires: [ForestFire]? = nil) {
        if let fires = fires {
            self.fires = fires
        }
    }
    // MARK: - Functions

    func refreshFireList(with: URL? = nil) {
        self.failed = false
        self.fires = [ForestFire]()
        let start = Date()
        let group = DispatchGroup()
        
        // Secondary fire source (inciweb)
        let url2 = with ?? URL(string: "https://inciweb.nwcg.gov/feeds/json/esri/")!
        print("🔥 [ Grabbing secondary fire data ]")
        
        let task2 = URLSession.shared.dataTask(with: url2) { unsafeData, _, error in
            guard let data: Data = unsafeData else {
                self.failed = true
                print("🚫 No fire data found")
                return
            }

            let jsonDecoder = JSONDecoder()

            jsonDecoder.dateDecodingStrategyFormatters = [
                DateFormatter.iso8601Full,
                DateFormatter.iso8601,
                DateFormatter.iso8601NoExtention,
                DateFormatter.dateTimeSeconds
            ]

            DispatchQueue.main.async {
                do {
                    let newFires = try jsonDecoder.decode(InciWebIncidents.self, from: data)
                    let calOnly = UserDefaults.standard.bool(forKey: "californiaOnly") 
                    
                    let filteredNewFires = newFires.markers.filter({
                        $0.type == "Wildfire" && ($0.state == "CALIFORNIA" || calOnly) 
                    })
                    
                    var unAddedFires = [ForestFire]()
                    for fireI in self.fires.indices {
                        for inciI in filteredNewFires.indices {
                            
                            let inciWebFire = filteredNewFires[inciI]
                            
                            let forestFireObject = ForestFire(
                                name: inciWebFire.name,
                                updated: inciWebFire.updated,
                                location: inciWebFire.state.capitalized,
                                latitude: inciWebFire.lat.becomeDouble(),
                                longitude: inciWebFire.lng.becomeDouble(),
                                acres: inciWebFire.size.becomeInt(),
                                contained: inciWebFire.contained.becomeInt(),
                                relURL: inciWebFire.url,
                                sourceType: .inciweb
                            )
                            
                            if  self.fires[fireI].acresO == nil &&
                                filteredNewFires[inciI].coordinate == self.fires[fireI].coordinate ||
                                filteredNewFires[inciI].name == self.fires[fireI].name {
                                
                                print("🔎 Found matching fires: \(filteredNewFires[inciI].name)")
                                self.fires[fireI] = forestFireObject
                                
                            } else if fireI == 0 && self.fires.filter({$0.name == filteredNewFires[inciI].name}).count == 0 {
                                unAddedFires.append(forestFireObject)
                            }
                        }
                    }
                    
                    self.fires += unAddedFires
                    self.fires = self.fires.sorted(by: ForestFire.dateUpdated)
                    
                } catch {
                    self.failed = true
                    print("🚫 JSON Decoding failed: \(error)")
                }
                group.leave()
            }
        }
        
        self.progress[1] = task2.progress

        // Primary data source
        let url = with ?? URL(string: "https://www.fire.ca.gov/umbraco/Api/IncidentApi/GetIncidents")!
        print("🔥 [ Grabbing new fires ]")
        
        let task = URLSession.shared.dataTask(with: url) { unsafeData, _, error in
            guard let data: Data = unsafeData else {
                self.failed = true
                print("🚫 No fire data found")
                return
            }

            let jsonDecoder = JSONDecoder()

            jsonDecoder.dateDecodingStrategyFormatters = [
                DateFormatter.iso8601Full,
                DateFormatter.iso8601,
                DateFormatter.iso8601NoExtention
            ]

            DispatchQueue.main.async {
                do {
                    let newFires = try jsonDecoder.decode(Incidents.self, from: data)
                    self.fires = newFires.incidents.sorted(by: ForestFire.dateUpdated)
                } catch {
                    self.failed = true
                    print("🚫 JSON Decoding failed: \(error)")
                }
                
                group.enter()
                task2.resume()
                group.leave()
            }
        }
        
        self.progress[0] = task.progress
        
        group.enter()
        task.resume()

        group.notify(queue: .main) {
            print("✅ Done grabbing fires! (\(round(1000.0 * Date().timeIntervalSince(start)) / 1000.0))")
        }
    }
}
