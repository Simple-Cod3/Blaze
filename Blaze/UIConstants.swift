//
//  UIConstants.swift
//  Blaze
//
//  Created by Paul Wong on 10/17/21.
//

import SwiftUI
import UIKit
import Foundation

struct Device {
    /// iOS Version
    static let version = UIDevice.current.systemVersion
    /// `VendorID` with `UDID` format
    static let udid: String = (UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString)
        .replacingOccurrences(of: "-", with: "42")
    
    /// Get device model
    static func model() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let modelCode = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return modelCode
    }
}

class UIConstants: ObservableObject {
    static var margin: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if [
                "iPhone8,1", // iPhone 6S
                "iPhone8,4", // iPhone SE
                "iPhone9,1", // iPhone 7 (CDMA)
                "iPhone9,3", // iPhone 7 (GSM)
                "iPhone10,1", // iPhone 8 (CDMA)
                "iPhone10,4", // iPhone 8 (GSM)
                "iPhone11,8", // iPhone XR
                "iPhone12,1", // iPhone 11
                "iPhone12,8", // iPhone SE (2nd Gen)
                "iPod9,1" // iPod Touch 7th Generation
            ]
            .contains(Device.model()) {
                return 20
            }
            
            return 16
        } else {
            return 20
        }
    }
    
    static var bottomPadding: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if [
                "iPhone1,1", // iPhone
                "iPhone1,2", // iPhone 3G
                "iPhone2,1", // iPhone 3GS
                "iPhone3,1", // iPhone 4 (GSM)
                "iPhone3,2", // iPhone 4 (GSM Rev A)
                "iPhone3,3", // iPhone 4 (CDMA/Verizon/Sprint)
                "iPhone4,1", // iPhone 4S
                "iPhone5,1", // iPhone 5 (model A1428, AT&T/Canada)
                "iPhone5,2", // iPhone 5 (model A1429, everything else)
                "iPhone5,3", // iPhone 5c (model A1456, A1532 | GSM)
                "iPhone5,4", // iPhone 5c (model A1507, A1516, A1526 (China), A1529 | Global)
                "iPhone6,1", // iPhone 5s (model A1433, A1533 | GSM)
                "iPhone6,2", // iPhone 5s (model A1457, A1518, A1528 (China), A1530 | Global)
                "iPhone7,1", // iPhone 6 Plus
                "iPhone7,2", // iPhone 6
                "iPhone8,1", // iPhone 6S
                "iPhone8,2", // iPhone 6S Plus
                "iPhone8,4", // iPhone SE
                "iPhone9,1", // iPhone 7 (CDMA)
                "iPhone9,3", // iPhone 7 (GSM)
                "iPhone9,2", // iPhone 7 Plus (CDMA)
                "iPhone9,4", // iPhone 7 Plus (GSM)
                "iPhone10,1", // iPhone 8 (CDMA)
                "iPhone10,4", // iPhone 8 (GSM)
                "iPhone10,2", // iPhone 8 Plus (CDMA)
                "iPhone10,5" // iPhone 8 Plus (GSM)
            ]
            .contains(Device.model()) {
                return 0
            }
            
            return UIConstants.margin*1.3
        } else {
            return 0
        }
    }
}
