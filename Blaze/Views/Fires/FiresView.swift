//
//  FiresView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct FiresView: View {
    @EnvironmentObject var fireB: FireBackend
    @State var select = 0
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image("hydrant").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .padding(20)
                    
                    HStack {
                        Header(title: "Big Fires", desc: "The US Forest Service is in unified command with CAL FIRE on the Elkhorn Fire, which is burning in the Tomhead Mountain area west of Red Bluff.")
                        Spacer()
                    }
                    
                    Spacer()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(fireB.fires.indices, id: \.self) { i in
                                Button(action: { select = i }) {
                                    MiniFireCard(selected: i == select, fireData: fireB.fires[i])
                                }
                            }
                        }
                            .padding(20)
                    }
                }
                    .navigationBarTitle("Big Fires", displayMode: .inline)
                .navigationBarHidden(true)
            }
        }
    }
}

struct FiresView_Previews: PreviewProvider {
    static var previews: some View {
        FiresView()
    }
}
