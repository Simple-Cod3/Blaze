//
//  SettingsCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/7/20.
//

import SwiftUI

struct UnitsCard: View {
    
    @State var selection: Int = units.firstIndex(of: currentUnit ?? units[0])!
    
    var title: String
    var desc: String
        
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .fontWeight(.medium)
                .font(.title2)
                .foregroundColor(.primary)
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                Text(desc)
                    .font(desc.count > 30 ? .footnote : .body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                Text(desc)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Divider()
                .padding(.vertical, 10)
                .padding(.bottom, 5)
            
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
