//
//  FullInformationView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/8/20.
//

import SwiftUI

struct FullInformationView: View {
    @EnvironmentObject var fireBackend: FireBackend
    @ObservedObject var searchBar = SearchBar()
    @Binding var show: Bool
    
    var body: some View {
        NavigationView {
            List(fireBackend.fires.filter {
                searchBar.text == "" ||
                $0.name.lowercased().contains(searchBar.text.lowercased()) ||
                $0.location.lowercased().contains(searchBar.text.lowercased()) ||
                $0.searchKeywords?.lowercased().contains(searchBar.text.lowercased()) == true ||
                $0.searchDescription?.lowercased().contains(searchBar.text.lowercased()) == true
            }) { fire in
                NavigationLink(destination: InformationViewInner(show: $show, fireData: fire)) {
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(fire.name)
                                .font(.headline)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("\(Image(systemName: "mappin.and.ellipse")) \(fire.getLocation())")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        Spacer()
                        InfoButton()
                    }
                    .padding(.vertical, 10)
                }
            }
            .navigationBarTitle("All Fires")
            .navigationBarItems(trailing: Button(action: { show.toggle() }) { CloseModalButton() })
            .add(self.searchBar)
        }
    }
}
