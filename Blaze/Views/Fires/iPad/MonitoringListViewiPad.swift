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
                    Button(action: {withAnimation(.spring()) {columns = 3.0}}) {
                        GenericButton(icon: "square.grid.3x2", color: columns == 3 ? .blaze : .secondary)
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
                        .foregroundColor(.secondary)
                        .frame(width: 200)
                        .multilineTextAlignment(.center)
                }
                
                LazyVGrid(columns: layout, spacing: 10) {
                    ForEach(fireB.monitoringFires) { fire in
                        NavigationLink(destination: FireMapViewiPad(fireData: fire)) {
                            FlexibleFireInfo(columns: $columns, fireData: fire)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .contextMenu {
                            Button(action: { fireB.removeMonitoredFire(name: fire.name) }) {
                                Label("Remove Pin", systemImage: "pin.slash")
                            }
                        }
                        .padding(5)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: columns != 1 ? 0 : 15, style: .continuous))
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .padding(.bottom, 50)
                .animation(.spring(), value: fireB.monitoringFires)
                .background(Color(.systemBackground))
            }
            .navigationBarTitle("Monitoring List", displayMode: .large)
            .navigationBarItems(
                trailing: Button(action: { show = true }) {
                    Image(systemName: "plus.circle")
                        .font(Font.title2.weight(.regular))
                }
            )
        }
        .sheet(isPresented: $show) {
            AddMonitoringFires(show: $show).environmentObject(fireB)
        }
    }
}
