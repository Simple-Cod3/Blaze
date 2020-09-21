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
                .fontWeight(.semibold)
                .font(.title)
                .foregroundColor(.primary)
            Text(desc)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            Divider().padding(.bottom, 5)
            
            Picker("", selection: $selection) {
                ForEach(units.indices) { i in
                    Text(units[i]).tag(i)
                }
            }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selection, perform: { i in
                    setUnit(unit: units[i])
                    print("🔄 Changed Area Units to: \(UserDefaults.standard.string(forKey: "areaUnits")!)")
                })
                
        }
            .padding(20)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .padding(.horizontal, 20)
    }
}

struct UnitsCard_Previews: PreviewProvider {
    static var previews: some View {
        UnitsCard(title: "Units", desc: "Change the units of the fire spread area")
    }
}
