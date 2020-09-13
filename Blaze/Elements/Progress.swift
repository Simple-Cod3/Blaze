//
//  ProgressBar.swift
//  Blaze
//
//  Created by Nathan Choi on 9/13/20.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var progressObj: Progress
    @Binding var progress: Double
    @Binding var done: Bool
    @State var timer = Timer
        .publish(every: 0.1, on: .main, in: .common)
        .autoconnect()
    
    var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack(spacing: 10) {
                ProgressView()
                Text("Loading \(text)...")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            ProgressBar(progress: $progress)
                .onReceive(timer) { _ in
                    withAnimation {
                        self.progress = progressObj.fractionCompleted
                    }
                    if progressObj.isFinished {
                        timer.upstream.connect().cancel()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.done = true
                        }
                    }
                }
            Spacer()
        }.padding(50)
    }
}

struct ProgressBar: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader { g in
            ZStack(alignment: .leading) {
                Color.blaze.opacity(0.3)
                Color.blaze
                    .frame(width: g.size.width*CGFloat(min(self.progress, 1.0)))
            }
                .frame(height: 4)
                .clipShape(RoundedRectangle(cornerRadius: 2, style: .continuous))
                .animation(Animation.spring(dampingFraction: 0.5), value: self.progress)
        }.frame(height: 4)
    }
}
