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
    @Published var progress = Progress()

    // MARK: - Init Function

    init(fires: [ForestFire]? = nil) {
        if let fires = fires {
            self.fires = fires
        }
    }
    // MARK: - Functions

    func refreshFireList(with: URL? = nil) {
        self.failed = false
        let start = Date()
        let group = DispatchGroup()

        let url = with ?? URL(string: "https://www.fire.ca.gov/umbraco/Api/IncidentApi/GetIncidents")!
        print("🔥 [ Grabbing new fires ]")
        //let url2 = with ?? URL(string: "https://inciweb.nwcg.gov/js/markers.json")!
        //print("🔥 [ Grabbing secondary fire data ]")

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
                group.leave()
            }

        }

        self.progress = task.progress

        group.enter()
        task.resume()

        group.notify(queue: .main) {
            print("✅ Done grabbing fires! (\(round(1000.0 * Date().timeIntervalSince(start)) / 1000.0))")
        }
    }
}
