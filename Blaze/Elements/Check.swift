//
//  Check.swift
//  Blaze
//
//  Created by Nathan Choi on 10/3/20.
//

import SwiftUI

struct Check: View {
    @State var show = false
    @State var yes: Bool
    @State var interval: Double
    
    var body: some View {
        Group {
            if yes {
                ZStack {
                    Color.red.opacity(0.2).frame(width: 25)
                        .clipShape(Circle())
                        .scaleEffect(show ? 1 : 0)
                        .animation(.spring())
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color.red.opacity(0.7))
                        .scaleEffect(show ? 1 : 0)
                        .animation(.spring(response: 1))
                }
            } else {
                ZStack {
                    Color.green.opacity(0.2).frame(width: 25)
                        .clipShape(Circle())
                        .scaleEffect(show ? 1 : 0)
                        .animation(.spring())
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color.green.opacity(0.7))
                        .scaleEffect(show ? 1 : 0)
                        .animation(.spring(response: 1))
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                show = true
            }
        }
    }
}

struct Check_Previews: PreviewProvider {
    static var previews: some View {
        Check(yes: true, interval: 2)
    }
}
