//
//  SettingsCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/7/20.
//

import SwiftUI

struct UnitsCard: View {
    var title: String
    var desc: String
    
    @State var selection: Int = units.firstIndex(of: currentUnit ?? units[0])!
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .fontWeight(.medium)
                .font(.title)
                .foregroundColor(.primary)
            Text(desc)
                .font(.body)
                .fontWeight(.regular)
                .foregroundColor(.secondary)
            
            Divider().padding(.bottom, 5)
            
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
            
        }
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}
