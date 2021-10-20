//
//  SettingsCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/7/20.
//

import SwiftUI

struct UnitsCard: View {
    
    @Environment(\.colorScheme) var colorScheme

    @State var selection: Int = units.firstIndex(of: currentUnit ?? units[0])!
    
    var title: String
    var desc: String
        
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Text(desc)
                .font(.subheadline)
                .foregroundColor(Color(.tertiaryLabel))
            
            Picker("", selection: $selection) {
                ForEach(units.indices) { index in
                    Text(units[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selection, perform: { index in
                setUnit(unit: units[index])
                print("🔄 Changed Area Units to: \(UserDefaults.standard.string(forKey: "areaUnits")!)")
            })
            .padding(.top, 5)
        }
        .padding(16)
        .background(Color(.quaternarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}
