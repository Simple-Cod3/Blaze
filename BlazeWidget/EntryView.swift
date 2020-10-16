//
//  EntryView.swift
//  BlazeWidgetExtension
//
//  Created by Max on 10/15/20.
//

import SwiftUI

struct EntryView: View {
    let model: WidgetContent
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.number)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.trailing], 15)
                .foregroundColor(Color.black)
        }
        .background(Color.orange)
        .padding()
        .cornerRadius(6)
    }
    
}
