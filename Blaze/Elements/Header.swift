//
//  Header.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI

struct Header: View {
    var title: String
    var desc: String?
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.system(size: 60))
                .fontWeight(.bold)
                .foregroundColor(.blaze)
            
            if let desc = desc {
                Text(desc)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)            }
        }
        .padding(.horizontal, 20)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(title: "Big Fires", desc: "The US Forest Service is in unified command with CAL FIRE on the Elkhorn Fire, which is burning in the Tomhead Mountain area west of Red Bluff.")
    }
}
