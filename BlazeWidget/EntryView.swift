//
//  EntryView.swift
//  BlazeWidgetExtension
//
//  Created by Mike on 10/15/20.
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

//struct EntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryView()
//    }
//}
