//
//  TestView.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Header(title: "Big Fires", desc: "The US Forest Service is in unified command with CAL FIRE on the Elkhorn Fire, which is burning in the Tomhead Mountain area west of Red Bluff.")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    TestCard(title: "ElkHorn Fire", acres: "39,995 Acres")
                    TestCard(title: "ElkHorn Fire", acres: "39,995 Acres")
                }
                .padding(.leading, 20)
            }
        }
    }
}

// Tab bar is needed.

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
