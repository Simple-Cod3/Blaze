//
//  PhoneCard.swift
//  Blaze
//
//  Created by Paul Wong on 10/22/21.
//

import SwiftUI

struct PhoneCard: View {
        
    @Environment(\.colorScheme) var colorScheme
    
    var togglePin: (PhoneNumber) -> Void
    var number: PhoneNumber
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 7) {
                Text(number.name?.replacingOccurrences(of: " CLOSED", with: "") ?? "Unknown Name")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                HStack(spacing: 5) {
                    Text((number.county ?? "Unknown") + " • " + (number.phoneNumber  ?? "Unknown Number"))
                }
                .font(.system(size: textSize(textStyle: .subheadline)-1).weight(.medium))
                .foregroundColor(.orange)
            }
            
            Spacer()
            
            Check(yes: number.name!.contains(" CLOSED"))
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(16)
        .background(colorScheme == .dark ? Color(.tertiarySystemFill) : Color(.tertiarySystemBackground).opacity(0.79))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .contextMenu {
            Button(action: { togglePin(number) }) { Label("Pin/Unpin Facility", systemImage: "pin") }
        }
    }
}
