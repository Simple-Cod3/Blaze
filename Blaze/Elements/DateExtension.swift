//
//  DateExtension.swift
//  Blaze
//
//  Created by Nathan Choi on 9/2/20.
//

import Foundation

/// https://medium.com/@iamjdpatel/time-ago-extension-for-date-swift-ed9b8d0a3a54
extension Date {
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        
        return String(format: formatter.string(from: localTime(), to: Date()) ?? "", locale: .current)
    }
    
    func localTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}
