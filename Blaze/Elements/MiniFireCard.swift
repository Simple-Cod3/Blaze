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
                .padding([.top, .leading], 15)
                .padding(.bottom, 10)
                .foregroundColor(.secondary)
            Text(fireData.name)
                .font(.system(size: fireData.name.count > 15 ? 20 : 26))
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
                .padding(.horizontal, 15)
            
            Spacer()
            HStack {
                Text(area ? fireData.getAreaString(areaUnits) : fireData.updated.getElapsedInterval() + " ago")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.blaze)
                Spacer()
                NavigationLink(destination: FireMapView(fireData: fireData)) {
                    Text("MAP")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.blaze)
                        .clipShape(Capsule())
                }
            }.padding(15)
        }
            .frame(width: 210, height: 190)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
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
    }
}
