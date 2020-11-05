//
//  MonitoringListView.swift
//  Blaze
//
//  Created by Paul Wong on 11/3/20.
//

import SwiftUI

struct MonitoringListView: View {
    @EnvironmentObject var fireB: FireBackend
    @State private var columns: CGFloat = 2
    @State private var show = false
    
    private var layout: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(columns))
    }
    
    var body: some View {
        ScrollView {
            HStack(spacing: 20) {
                Button(action: {withAnimation(.spring()) {columns = 1.0}}) {
                    GenericButton(icon: "list.dash", color: columns == 1 ? .blaze : .secondary)
                }
                Button(action: {withAnimation(.spring()) {columns = 2.0}}) {
                    GenericButton(icon: "rectangle.grid.2x2", color: columns == 2 ? .blaze : .secondary)
                }
                Button(action: {withAnimation(.spring()) {columns = 3.0}}) {
                    GenericButton(icon: "square.grid.3x2", color: columns == 3 ? .blaze : .secondary)
                }
            }
            .padding(20)
            .background(Color(.systemBackground).frame(height: UIScreen.main.bounds.maxY), alignment: .bottom)
            
            if fireB.monitoringFires.count == 0 {
                Image("bandage").resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
                    .padding(.top, 50)
                Text("Pinned fires\nwill been shown here")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            LazyVGrid(columns: layout, spacing: 5) {
                ForEach(fireB.monitoringFires) { fire in
                    FlexibleFireInfo(columns: $columns, fireData: fire)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: columns != 1 ? 0 : 10, style: .continuous))
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .padding(.bottom, 50)
        }
        .animation(.spring(), value: fireB.monitoringFires)
        .background(Color(.secondarySystemBackground))
        .navigationBarTitle("Monitoring List", displayMode: .large)
        .navigationBarItems(
            trailing: Button(action: { show = true }) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 25))
            }
        )
        .sheet(isPresented: $show) {
            NavigationView {
                List(
                    fireB.fires
                        .sorted(by: { $0.name < $1.name })
                        .filter({ !fireB.monitoringFires.map {$0.name}.contains($0.name) })
                ) { item in
                    Button(action: {
                        fireB.addMonitoredFire(name: item.name)
                        show = false
                    }) {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.getLocation())
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }.navigationBarTitle("Monitor Fires")
            }
        }
    }
}

struct FlexibleFireInfo: View {
    @EnvironmentObject var fireB: FireBackend
    @Binding var columns: CGFloat
    @State private var show = false
    
    var fireData: ForestFire
    
    var body: some View {
        NavigationLink(destination: FireMapView(fireData: fireData)) {
            LazyVStack(alignment: columns == 1 ? .leading : .center, spacing: 5) {
                Text(fireData.name)
                    .font(columns != 3 ? Font.headline.weight(.semibold) : Font.subheadline.weight(.semibold))
                    .foregroundColor(.blaze)
                    .multilineTextAlignment(columns != 1 ? .center : .leading)
                if columns != 3 {
                    Text(fireData.getAreaString())
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .transition(.scale)
                    Text(fireData.getContained() + " contained")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .transition(.scale)
                }
            }
        }
        .frame(height: columns == 1 ? 100 : 150)
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemBackground))
        )
        .contextMenu {
            Button(action: { fireB.removeMonitoredFire(name: fireData.name) }) {
                Label("Remove Pin", systemImage: "pin")
            }
            Button(action: fireData.share) { Label("Share Fire", systemImage: "square.and.arrow.up") }
        }
        .sheet(isPresented: $show) {
            InformationView(show: $show, fireData: fireData)
        }
        .padding(5)
    }
}
