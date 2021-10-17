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
                "iPhone8,1",
                "iPhone8,4",
                "iPhone9,1",
                "iPhone9,3",
                "iPhone10,1",
                "iPhone10,4",
                "iPhone11,8",
                "iPhone12,1",
                "iPhone12,8",
                "iPod9,1"
            ]
            .contains(Device.model()) {
                return 20
            }

            return 16
        } else {
            return 20
        }
    }
}
