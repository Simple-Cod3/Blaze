//
//  MonitoringListViewiPad.swift
//  Blaze
//
//  Created by Paul Wong on 11/3/20.
//

import SwiftUI

struct MonitoringListViewiPad: View {
    @EnvironmentObject var fireB: FireBackend
    @State private var columns: CGFloat = 2
    @State private var show = false
    @Binding var showModal: Bool
    
    private var layout: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(columns))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack(spacing: 20) {
                    Button(action: {withAnimation(.spring()) {columns = 1.0}}) {
                        GenericButton(icon: "rectangle.grid.1x2", color: columns == 1 ? .blaze : .secondary)
                    }
                    Button(action: {withAnimation(.spring()) {columns = 2.0}}) {
                        GenericButton(icon: "rectangle.grid.2x2", color: columns == 2 ? .blaze : .secondary)
                    }
                }
                .padding(20)
                .background(Color(.secondarySystemBackground).frame(height: UIScreen.main.bounds.maxY), alignment: .bottom)
                
                if fireB.monitoringFires.count == 0 {
                    Image("bandage").resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150)
                        .padding(.top, 150)
                        .padding(.bottom, 20)
                    Text("Peal off this bandage by pinning wildfires.")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                        .frame(width: 200)
                        .multilineTextAlignment(.center)
                }
                
                LazyVGrid(columns: layout, spacing: 10) {
                    ForEach(fireB.monitoringFires) { fire in
                        FlexibleFireInfoiPad(columns: $columns, fireData: fire)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: columns != 1 ? 0 : 15, style: .continuous))
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .padding(.bottom, 50)
            }
            .animation(.spring(), value: fireB.monitoringFires)
            .background(Color(.systemBackground))
            .navigationBarTitle("Monitoring List", displayMode: .large)
            .navigationBarItems(
                trailing: Button(action: { show = true }) {
                    Image(systemName: "plus.circle")
                        .font(Font.title2.weight(.regular))
                }
            )
        }
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
                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.getLocation())
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 5)
                    }
                }.navigationBarTitle("Monitor Fires")
                .navigationBarItems(trailing:
                    Button(action: { showModal.toggle() }) {
                        CloseModalButton()
                    }
                )
            }
        }
    }
}

struct FlexibleFireInfoiPad: View {
    @EnvironmentObject var fireB: FireBackend
    @Binding var columns: CGFloat
    @State private var show = false
    
    var fireData: ForestFire
    
    var body: some View {
        NavigationLink(destination: FireMapViewiPad(fireData: fireData)) {
            LazyVStack(alignment: .leading, spacing: 5) {
                Image(systemName: "flame")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 5)
                Text(fireData.name)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .padding(.bottom, 5)
                                
                Text(fireData.getAreaString())
                    .foregroundColor(.blaze)
                    .transition(.scale)
                
                Text(fireData.getContained() + " contained")
                    .foregroundColor(.secondary)
                    .transition(.scale)
            }
            .frame(height: columns == 1 ? 120 : 150)
        }
        .frame(height: columns == 1 ? 120 : 150)
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .contextMenu {
            Button(action: { fireB.removeMonitoredFire(name: fireData.name) }) {
                Label("Remove Pin", systemImage: "pin.slash")
            }
        }
        .sheet(isPresented: $show) {
            InformationView(show: $show, fireData: fireData)
        }
        .padding(5)
    }
}
