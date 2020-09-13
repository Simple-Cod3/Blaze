//
//  MiniFireCard.swift
//  Blaze
//
//  Created by Nathan Choi on 9/4/20.
//

import SwiftUI

struct MiniFireCard: View {
    @AppStorage("areaUnits") var areaUnits: String = UserDefaults.standard.string(forKey: "areaUnits")!
    
    var selected: Bool
    var fireData: ForestFire
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: "flame")
                .font(.system(size: 26))
                .padding([.top, .leading], 15)
                .padding(.bottom, 10)
                .foregroundColor(selected ? .white : .secondary)
            Text(fireData.name)
                .font(.system(size: 26))
                .fontWeight(.bold)
                .foregroundColor(selected ? .white : .secondary)
                .padding(.horizontal, 15)
            
            Spacer()
            HStack {
                Text(fireData.getAreaString(areaUnits))
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(selected ? .white : .blaze)
                Spacer()
                NavigationLink(destination: FireMapView(fireData: fireData)) {
                    Text("MAP")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(selected ? .blaze : .white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(selected ? Color.white : Color.blaze)
                        .clipShape(Capsule())
                }
            }.padding(15)
        }
            .frame(width: 200, height: 180)
            .background(selected ? Color.blaze : Color(.secondarySystemBackground))
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
            MiniFireCard(selected: true, fireData: fire)
        }
    }
}
