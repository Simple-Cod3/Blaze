//
//  WidgetTarget.swift
//  Blaze
//
//  Created by Paul Wong on 10/16/20.
//

import SwiftUI

struct SmallWdvidget: View {
    var size: String
    
    var body: some View {
        VStack {
            Text("The biggest wildfire in California is now ")
                .font(.title2)
                .fontWeight(.semibold)
            + Text(size)
                .foregroundColor(Color.yellow)
                .font(.title2)
                .fontWeight(.semibold)
            + Text(" acres")
                .foregroundColor(.primary)
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
}

