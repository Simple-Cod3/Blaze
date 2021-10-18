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
    @Published var monitoringFires = [ForestFire]()
    @Published var failed = false
    @Published var progress = [Progress(), Progress()]

    // MARK: - Init Function

    init(fires: [ForestFire]? = nil) {
        if let fires = fires {
            self.fires = fires
        }
    }
    // MARK: - Functions
    func updateMonitored() {
        if let monitored = UserDefaults.standard.stringArray(forKey: "monitoringFires") {
            self.monitoringFires = self.fires.filter({ monitored.contains($0.name) })
        }
    }
    
    func addMonitoredFire(name: String) {
        if monitoringFires.allSatisfy({ $0.name != name }) {
            guard let fire = fires.filter({ $0.name == name }).first else {
                return
            }
            
            monitoringFires.append(fire)
            UserDefaults.standard.setValue(monitoringFires.map { $0.name }, forKey: "monitoringFires")
        }
    }
    
    func removeMonitoredFire(name: String) {
        monitoringFires = monitoringFires.filter({ $0.name != name })
        UserDefaults.standard.setValue(monitoringFires.map { $0.name }, forKey: "monitoringFires")
    }

    private func sameFire(caFire: ForestFire, inciWebFire: ForestFire) -> Bool {
        return
            caFire.coordinate == inciWebFire.coordinate ||
            caFire.name == inciWebFire.name ||
            caFire.name == inciWebFire.name.replacingOccurrences(of: " Fire", with: "") ||
            caFire.name + " (CA)" == inciWebFire.name
    }
    
    func refreshFireList(with: URL? = nil) {
        self.failed = false
        self.fires = [ForestFire]()
        let start = Date()
        let group = DispatchGroup()
        
        // Secondary fire source (inciweb)
        let url2 = with ?? URL(string: "https://inciweb.nwcg.gov/feeds/json/esri/")!

        let task2 = URLSession.shared.dataTask(with: url2) { [self] unsafeData, _, error in
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

            do {
                let newFires = try jsonDecoder.decode(InciWebIncidents.self, from: data)

                // Filter to only Wildfires (and appropriate, to only California Wildfires)
                let calOnly = UserDefaults.standard.bool(forKey: "californiaOnly")

                // Inciweb Fires have more information!
                let inciWebFires = newFires.markers.filter({
                    $0.type == "Wildfire" && ($0.state == "CALIFORNIA" || calOnly)
                })

                // Fires that won't merge but will still be added to the global list
                var uniqueInciWebFires = [ForestFire]()
                var builtUniqueList = false

                let firesListToReplaceOld: [ForestFire] = self.fires.map { initialFire in
                    for inciWebFire in inciWebFires {
                        let inciWebFireObject = ForestFire(
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

                        // Various checks to see if the fires are the same between the two sources
                        if self.sameFire(caFire: initialFire, inciWebFire: inciWebFireObject){
                            print("Merged:", inciWebFireObject.name)
                            return inciWebFireObject
                        } else if !builtUniqueList && !self.fires.contains(where: { self.sameFire(caFire: $0, inciWebFire: inciWebFireObject) }) {
                            uniqueInciWebFires.append(inciWebFireObject)
                            print("Unique:", inciWebFireObject.name)
                        }
                    }

                    builtUniqueList = true
                    return initialFire
                }

                DispatchQueue.main.async {
                    print("NewMaps", firesListToReplaceOld.map { $0.name })
                    print("NewMaps", uniqueInciWebFires.map { $0.name })
                    self.fires = firesListToReplaceOld
                    self.fires += uniqueInciWebFires
                    self.fires = self.fires.sorted(by: ForestFire.dateUpdated)
                    group.leave()
                }
            } catch {
                DispatchQueue.main.async {
                    self.failed = true
                    group.leave()
                    print("🚫 JSON Decoding failed: \(error)")
                }
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

            do {
                let newFires = try jsonDecoder.decode(Incidents.self, from: data)

                DispatchQueue.main.async {
                    self.fires = newFires.incidents.sorted(by: ForestFire.dateUpdated)
                }
            } catch {
                DispatchQueue.main.async {
                    self.failed = true
                    print("🚫 JSON Decoding failed: \(error)")
                }
            }

            group.enter()
            task2.resume()
            print("🔥 [ Grabbing secondary fire data ]")
            group.leave()

        }
        
        self.progress[0] = task.progress
        
        group.enter()
        task.resume()

        group.notify(queue: .main) {
            self.updateMonitored()
            print("✅ Done grabbing fires! (\(round(1000.0 * Date().timeIntervalSince(start)) / 1000.0))")
        }
    }
}
