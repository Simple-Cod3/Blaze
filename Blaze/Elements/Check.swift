//
//  Check.swift
//  Blaze
//
//  Created by Nathan Choi on 10/3/20.
//

import SwiftUI

struct Check: View {
    @State private var show = false
    @State var yes: Bool
    @State var interval: Double
    
    var size: CGFloat
    
    init(yes: Bool, interval: Double, size: CGFloat = 25) {
        self._yes = State(initialValue: yes)
        self._interval = State(initialValue: interval)
        self.size = size
    }
    
    var body: some View {
        Group {
            if yes {
                ZStack {
                    Color.red.opacity(0.2).frame(width: size)
                        .clipShape(Circle())
                        .scaleEffect(show ? 1 : 0)
                        .animation(.spring())
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: size*4/5))
                        .foregroundColor(Color.red.opacity(0.7))
                        .scaleEffect(show ? 1 : 0)
                        .animation(.spring(response: 1))
                }
            } else {
                ZStack {
                    Color.green.opacity(0.2).frame(width: size)
                        .clipShape(Circle())
                        .scaleEffect(show ? 1 : 0)
                        .animation(.spring())
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: size*4/5))
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
