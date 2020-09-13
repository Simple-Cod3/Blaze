//
//  FiresView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct FiresView: View {
    @EnvironmentObject var fireB: FireBackend
    @State var selectAll = 0
    @State var selectLargest = 0
    
    @State var timer = Timer.publish(
        every: 0.1,
        on: .main, in: .common).autoconnect()
    @State var progress = 0.0
    @State var done = false
    
    var body: some View {
        if done {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack {
                        Image("hydrant").resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .padding(25)
                        
                        HStack {
                            Header(title: "Wild Fires", desc: "Uncontrollable fires that spreads quickly over vegetation in rural areas. The scale of destruction is largely driven by weather conditions.")
                            Spacer()
                        }
                        
                        HStack(spacing: 20) {
                            NavigationLink(destination: FullFireMapView()) {
                                HStack {
                                    Spacer()
                                    Text("\(Image(systemName: "map")) All Fires")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            }
                                .padding(12)
                                .background(Color.blaze)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            NavigationLink(destination: Text("Hello")) {
                                HStack {
                                    Spacer()
                                    Text("\(Image(systemName: "tray.2")) Data")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.blaze)
                                    Spacer()
                                }
                            }
                                .padding(12)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }.padding(20)
                        
                        
                        Header2(title: "Largest Fires", description: "Largest fires (acres) will be shown.")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(
                                    fireB.fires.sorted(by: { $0.acres > $1.acres }).prefix(5).indices,
                                    id: \.self
                                ) { i in
                                    NavigationLink(destination: FireMapView(fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[i])) {
                                        MiniFireCard(
                                            selected: i == selectLargest,
                                            fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[i]
                                        )
                                    }
                                }
                                Spacer()
                                NavigationLink(destination: FullFireMapView()) {
                                    HStack {
                                        Image(systemName: "plus.circle")
                                        Text("View All")
                                    }
                                }
                            }
                                .padding(20)
                        }
                            .edgesIgnoringSafeArea(.horizontal)

                        Divider().padding(20)
                        
                        
                        Header2(title: "Latest Fires", description: "Fires with more updated information will be listed first.")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(fireB.fires.prefix(5).indices, id: \.self) { i in
                                    NavigationLink(destination: FireMapView(fireData: fireB.fires[i])) {
                                        MiniFireCard(selected: i == selectAll, fireData: fireB.fires[i])
                                    }
                                }
                                Spacer()
                                NavigationLink(destination: FullFireMapView()) {
                                    HStack {
                                        Image(systemName: "plus.circle")
                                        Text("View All")
                                    }
                                }
                            }
                                .padding(20)
                        }
                            .edgesIgnoringSafeArea(.horizontal)
                        
                        Spacer().frame(height: 50)
                    }
                        .navigationBarTitle("Big Fires", displayMode: .inline)
                        .navigationBarHidden(true)
                }
            }
        } else {
            VStack(alignment: .leading) {
                Spacer()
                HStack(spacing: 10) {
                    ProgressView()
                    Text("Loading Fires...")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                ProgressBar(progress: $progress)
                    .onReceive(timer) { _ in
                        withAnimation {
                            self.progress = fireB.progress.fractionCompleted
                        }
                        if fireB.progress.isFinished {
                            timer.upstream.connect().cancel()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.done = true
                            }
                        }
                    }
                Spacer()
            }.padding(50)
        }
    }
}

struct FiresView_Previews: PreviewProvider {
    static var previews: some View {
        FiresView().environmentObject(FireBackend())
    }
}
