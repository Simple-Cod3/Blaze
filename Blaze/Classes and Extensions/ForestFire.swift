//
//  ForestFire.swift
//  Blaze
//
//  Created by Nathan Choi on 9/2/20.
//

import Foundation
import MapKit
import SwiftUI

// MARK: - JSON Wrapper Object

struct Incidents: Codable {
    let incidents: [ForestFire]
    let allAcres: Int
    
    enum CodingKeys: String, CodingKey {
        case incidents = "Incidents"
        case allAcres = "AllAcres"
    }
}

// MARK: - Incident Struct

struct ForestFire: Codable, Identifiable, Equatable {
    static func == (lhs: ForestFire, rhs: ForestFire) -> Bool {
        return lhs.name == rhs.name && lhs.relURL == rhs.relURL
    }
    
    static func name(lhs: ForestFire, rhs: ForestFire) -> Bool {
        return lhs.name > rhs.name
    }
    
    static func dateUpdated(lhs: ForestFire, rhs: ForestFire) -> Bool {
        return lhs.updated > lhs.updated
    }
    
    let id = UUID()
    
    let name: String
    let location: String
    let latitude: Double
    let longitude: Double
    var acresO: Int?
    var containedO: Int?
    let controlStatement: String?
    let conditionStatement: String?
    let counties: [String]
    let countyIDS: String
    let searchDescription: String?
    let searchKeywords: String?
    let adminUnit: String?
    let updated: Date
    let started: Date
    let archiveYear: Int
    let incidentPublic: Bool
    let active: Bool
    let featured: Bool
    let calFireIncident: Bool
    let majorIncident: Bool
    let incidentFinal: Bool
    let status: String
    let relURL: String
    let structuresDestroyed: Int?
    let structuresDamaged: Int?
    let structuresThreatened: Int?
    let personnelInvolved: Int?
    let crewsInvolved: Int?
    let injuries: Int?
    let fatalities: Int?
    let helicopters: Int?
    let engines: Int?
    let dozers: Int?
    let waterTenders: Int?
    let airTankers: Int?
    var sourceType: SourceType? = .calfire
    
    enum SourceType {
        case calfire
        case inciweb
    }

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case location = "Location"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case acresO = "AcresBurned"
        case containedO = "PercentContained"
        case controlStatement = "ControlStatement"
        case conditionStatement = "ConditionStatement"
        case counties = "Counties"
        case countyIDS = "CountyIds"
        case searchDescription = "SearchDescription"
        case searchKeywords = "SearchKeywords"
        case adminUnit = "AdminUnit"
        case updated = "Updated"
        case started = "Started"
        case archiveYear = "ArchiveYear"
        case incidentPublic = "Public"
        case active = "Active"
        case featured = "Featured"
        case calFireIncident = "CalFireIncident"
        case majorIncident = "MajorIncident"
        case incidentFinal = "Final"
        case status = "Status"
        case relURL = "CanonicalUrl"
        case structuresDestroyed = "StructuresDestroyed"
        case structuresDamaged = "StructuresDamaged"
        case structuresThreatened = "StructuresThreatened"
        case personnelInvolved = "PersonnelInvolved"
        case crewsInvolved = "CrewsInvolved"
        case injuries = "Injuries"
        case fatalities = "Fatalities"
        case helicopters = "Helicopters"
        case engines = "Engines"
        case dozers = "Dozers"
        case waterTenders = "WaterTenders"
        case airTankers = "AirTankers"
    }
    
    init(
        name: String?=nil,
        updated: Date?=nil,
        started: Date?=nil,
        location: String?=nil,
        counties: [String]?=nil,
        latitude: Double?=nil,
        longitude: Double?=nil,
        acres: Int?=nil,
        contained: Int?=nil,
        relURL: String?=nil,
        sourceType: SourceType?=nil
    ) {
        self.name = name ?? "Wildfire"
        self.location = location ?? "Unknown"
        self.latitude = latitude ?? 31.7
        self.longitude = longitude ?? -122.3
        self.acresO = acres ?? 0
        self.containedO = contained ?? 0
        
        self.controlStatement = ""
        self.conditionStatement = ""
        self.counties = [""]
        self.countyIDS = ""
        self.searchDescription = ""
        self.searchKeywords = ""
        self.adminUnit = ""
        self.updated = updated ?? Date.distantFuture
        self.started = started ?? Date.distantFuture
        self.archiveYear = 2020
        self.incidentPublic = true
        self.active = true
        self.featured = false
        self.calFireIncident = true
        self.majorIncident = true
        self.incidentFinal = false
        self.status = "Active"
        self.relURL = relURL ?? "/"
        self.structuresDestroyed = -1
        self.structuresDamaged = -1
        self.structuresThreatened = -1
        self.personnelInvolved = -1
        self.crewsInvolved = -1
        self.injuries = -1
        self.fatalities = -1
        self.helicopters = -1
        self.engines = -1
        self.dozers = -1
        self.waterTenders = -1
        self.airTankers = -1
        
        self.sourceType = sourceType ?? .calfire
    }
    
    // MARK: - String Functions
    
    /// Returns a formatted string of the percent contained
    func getContained() -> String {
        return contained != -1 ? "\(contained)%" : "Unknown"
    }

    /// Returns a formatted string (with commas) of acres
    func getAreaString(_ unit: String? = nil) -> String {
        let unit = unit ?? UserDefaults.standard.string(forKey: "areaUnits") ?? "Acres"
        var conversionRate = 1
        
        switch unit {
        case "Sq. mi.":
            conversionRate = 640
        case "Sq. km.":
            conversionRate = 247
        default: /// acres
            conversionRate = 1
        }
        
        let num = acres / conversionRate
        
        return acres != -1 ? "\(num.inCommas() ?? String(num)) \(unit)" : "Unknown Area"
    }

    /// Returns a formatted string (with proper responses) for the location
    func getLocation() -> String {
        if location.lowercased() == "see details below" {
            return "More details on the website"
        }

        return location.prefix(1).capitalized + location.dropFirst()
    }
    
    func share(_ pos: Int) {
        var items = [
            "🔥【\(name)】\n",
            " • Location: \(getLocation())",
            " • Area Burned: \(getAreaString())",
            " • Contained: \(getContained())"
        ].map { "\($0)\n"}
        
        if let url = URL(string: url) {
            items.append("\n🔎 Learn more about it here: \n\(url)")
        }
        
        let actionView = UIActivityViewController(activityItems: [items.joined()], applicationActivities: nil)
        UIApplication.shared.windows[pos].rootViewController?.present(actionView, animated: true, completion: nil)
    }

    // MARK: - Computed Properties

    var acres: Int { self.acresO ?? -1 }
    var contained: Int { self.containedO ?? -1 }
    var url: String {
        switch self.sourceType {
        case .calfire:
            return "https://www.fire.ca.gov" + self.relURL
        case .inciweb:
            return "https://inciweb.nwcg.gov" + self.relURL
        default:
            return "https://www.fire.ca.gov" + self.relURL
        }
    }
    var km: Double { ( Double(self.acres) / 247 ).squareRoot() }
    
    /// Computes a `CLLocationCoordinate2D` from the latitude and longitude attribute
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

// MARK: - InciWeb Codable
struct InciWebIncidents: Codable {
    var markers: [Incident]
    
    init() {
        markers = [Incident]()
    }
    
    struct Incident: Codable, Identifiable {
        var id = UUID()
        var name: String
        var type: String
        var state: String
        var size: String
        var contained: String
        var lat: String
        var lng: String
        var updated: Date
        var url: String
        var summary: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case type
            case state
            case size
            case contained
            case lat
            case lng
            case updated
            case url
            case summary
        }
        
        /// Computes a `CLLocationCoordinate2D` from the latitude and longitude attribute
        var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: Double(lat) ?? -1, longitude: Double(lng) ?? -1)
        }
    }
}
