//
//  PhoneBackend.swift
//  Blaze
//
//  Created by Max on 9/27/20.
//

import Foundation
import SwiftUI
import CoreLocation

struct PhoneNumber : Codable, Identifiable {
    var id = UUID()
    var phoneNumber : String
    
    init(phoneNumber: String? = "xxx-xxx-xxxx"){
        self.phoneNumber = phoneNumber!
    }
    
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "PHONE_NUM"
    }
}

class PhoneBackend: ObservableObject {
    @Published var numbers = [PhoneNumber]()
    @Published var lost = false
    
    @ObservedObject var locationProvider = LocationProvider()
    var progress = Progress()

    init(numbers: [PhoneNumber]? = nil) {
        do {
            locationProvider.lm.allowsBackgroundLocationUpdates = false
            try locationProvider.start()
        }
        catch {
            print("!!! 🚫 Failed to get access to location 🚫 !!!")
            locationProvider.requestAuthorization()
        }
        
        if let numbers = numbers {
            self.numbers = numbers
        }
    }
    
    func refreshPhoneList(with: URL? = nil) {
        self.lost = false
        let group = DispatchGroup()
        
        var lat = locationProvider.location?.coordinate.latitude
        var long = locationProvider.location?.coordinate.longitude
        
        // if values are null put in dummy values
        if lat == nil || long == nil {
            lat = 37.7749
            long = -122.4194
            self.lost = true
        }
        
        print("☁️ [ Grabbing new numbers at (\(lat!), \(long!)) ]")
        
        // TODO: make this a function kinda gross
        let url = with ?? URL(string: "https://egis.fire.ca.gov/arcgis/rest/services/FRAP/Facilities/MapServer/0/query?where=1%3D1&outFields=*&geometry=\(lat!-50)%2C\(lat!+50)%2C\(long!-50)%2C\(long!+50)&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=json")!
        
        let task = URLSession.shared.dataTask(with: url) { unsafeData, reponse, error in
            guard let data: Data = unsafeData else {
                print("🚫 No data found")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            jsonDecoder.dateDecodingStrategyFormatters = [
                DateFormatter.iso8601Full,
                DateFormatter.iso8601,
                DateFormatter.iso8601NoExtention,
            ]
            
            DispatchQueue.main.async {
                do {
                    let newNumbers = try jsonDecoder.decode([PhoneNumber].self, from: data)
                    self.numbers = newNumbers
                } catch {
                    print("🚫 JSON Decoding failed: \(error)")
                }
                
                group.leave()
            }
        }
        
        self.progress = task.progress
        
        group.enter()
        task.resume()
        
        group.notify(queue: .main) {
            print("✅ Done grabbing numbers!")
        }
    }
    
}
