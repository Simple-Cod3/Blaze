//
//  PhoneBackend.swift
//  Blaze
//
//  Created by Max on 9/27/20.
//

import Foundation
import SwiftUI
import CoreLocation

struct PhoneNumbers: Codable, Identifiable {
    var id = UUID() 
    var features: [Features]
    
    enum CodingKeys: String, CodingKey {
        case features
    }
    struct Features: Codable, Identifiable {
        var id = UUID()
        var attributes: PhoneNumber
        
        enum CodingKeys: String, CodingKey {
            case attributes
        }
    }
}

struct PhoneNumber: Codable, Identifiable, Equatable {
    static func == (lhs: PhoneNumber, rhs: PhoneNumber) -> Bool {
        return lhs.name == rhs.name
    }
    
    var id = UUID()
    var name: String?
    var address: String?
    var city: String?
    var lat: Double?
    var long: Double?
    var phoneNumber: String?
    var county: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "NAME"
        case address = "ADDRESS"
        case city = "CITY"
        case lat = "LAT"
        case long = "LON"
        case phoneNumber = "PHONE_NUM"
        case county = "COUNTY"
    }
    
    func distanceFromUser(x: Double, y: Double) -> Double {
        return sqrt( pow(x - (lat ?? 999), 2) + pow(y - (long ?? 999), 2) )
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
            locationProvider.lm.allowsBackgroundLocationUpdates = false
            try locationProvider.start()
        } catch {
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

        let url = with ?? URL(
            string: "https://egis.fire.ca.gov/arcgis/rest/services/FRAP/Facilities/MapServer/0/query?where=1%3D1&outFields=*&geometry=\(lat!-50)%2C\(lat!+50)%2C\(long!-50)%2C\(long!+50)&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=json"
        )!
        
        let task = URLSession.shared.dataTask(with: url) { unsafeData, _, error in
            guard let data: Data = unsafeData else {
                print("🚫 No phone data found")
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
                    var newNumbers = try jsonDecoder.decode(PhoneNumbers.self, from: data)
                    newNumbers.features = newNumbers.features.filter {
                        $0.attributes.phoneNumber != nil &&
                            $0.attributes.phoneNumber!.count > 2
                    }
                    
                    self.numbers.append(
                        contentsOf: newNumbers.features
                            .map { $0.attributes }
                            .sorted(by: { $0.county ?? "???" < $1.county ?? "???" })
                    )
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
