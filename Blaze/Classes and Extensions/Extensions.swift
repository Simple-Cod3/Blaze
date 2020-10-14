//
//  NumberExtension.swift
//  Blaze
//
//  Created by Nathan Choi on 9/4/20.
//

import MapKit
import Foundation

extension Int {
    func inCommas() -> String? {
        let largeNumber = self
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:largeNumber))
    }
}

extension Double {
    func inCommas() -> String? {
        let largeNumber = self
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:largeNumber))
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
