//
//  PhoneNumberCell.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct PhoneNumberCell: View {
    var dismiss: () -> Void
    
    var addPin: (PhoneNumber) -> Void
    var number: PhoneNumber
    
    var body: some View {
        NavigationLink(destination: PhoneInfoView(dismiss: dismiss, phoneData: number)) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(number.name?.replacingOccurrences(of: " CLOSED", with: "") ?? "Unknown Name")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    HStack(spacing: 10) {
                        if let county = number.county {
                            Text(county)
                        }
                        
                        Text(number.phoneNumber!)

                        Spacer()
                    }
                    .foregroundColor(.secondary)
                }
                Spacer()
                Check(yes: number.name!.contains(" CLOSED"), interval: 0)
            }
            .padding(.vertical, 10)
        }
        .contextMenu {
            Button(action: { addPin(number) }) {
                HStack {
                    Text("Pin Facility")
                    
                    Image(systemName: "pin.circle.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 25))
                }
            }
        }
    }
}
