//
//  Header.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI

struct Header: View {
    
    private var title: String
    
    init(_ title: String) {
        self.title = title

    }
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.white)
    }
}
