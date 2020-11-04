//
//  MiniFireCard.swift
//  Blaze
//
//  Created by Nathan Choi on 9/4/20.
//

import SwiftUI

struct MiniFireCard: View {
    @AppStorage("areaUnits") var areaUnits: String = currentUnit ?? units[0]
    
    var selected: Bool
    var fireData: ForestFire
    var area: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: "flame")
                .font(.system(size: 26))
                .padding(.bottom, 10)
                .foregroundColor(.secondary)
            Text(fireData.name)
                .font(.system(size: fireData.name.count > 15 ? 20 : 26))
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Spacer()
            HStack {
                Text(area ? fireData.getAreaString(areaUnits) : fireData.updated.getElapsedInterval() + " ago")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(.blaze)
                Spacer()
                NavigationLink(destination: FireMapView(fireData: fireData)) {
                    RoundedButton("MAP")
                }
            }
        }
        .padding(15)
        .frame(width: 230, height: 190)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .contextMenu(ContextMenu(menuItems: {
            Text("Pin")
            Text("Map")
            Text("Menu Item 3")
        }))
        
    }
}

struct MiniFireCard_Previews: PreviewProvider {
    static var previews: some View {
        let fire = ForestFire(
            name: "Elkhorn Fire",
            location: "Lake Hughes Rd and Prospect Rd, southwest Lake Hughes",
            counties: ["Los Angeles"],
            latitude: 34.679402,
            longitude: -118.451917,
            acres: 45340,
            contained: 58,
            relURL: "/incidents/2020/8/12/lake-fire/"
        )

        NavigationView {
            MiniFireCard(selected: true, fireData: fire, area: true)
        }
        .padding(15)
        .frame(width: 230, height: 190)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}
