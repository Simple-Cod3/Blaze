//
//  MonitoringView.swift
//  Blaze
//
//  Created by Nathan Choi on 11/3/20.
//

import SwiftUI

struct MonitoringView: View {
    @EnvironmentObject var fires: FireBackend
    
    var body: some View {
        Text("\(Image(systemName: "hammer.fill"))\nComing Soon")
            .multilineTextAlignment(.center)
            .foregroundColor(.yellow)
    }
}

struct MonitoringView_Previews: PreviewProvider {
    static var previews: some View {
        MonitoringView().environmentObject(FireBackend())
    }
}
