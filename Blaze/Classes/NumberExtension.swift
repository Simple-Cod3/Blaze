//
//  NumberExtension.swift
//  Blaze
//
//  Created by Nathan Choi on 9/4/20.
//

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

