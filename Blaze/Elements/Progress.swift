//
//  ProgressBar.swift
//  Blaze
//
//  Created by Nathan Choi on 9/13/20.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var progressObjs: [Progress]
    @Binding var progress: Double
    @Binding var done: Bool
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                ProgressView()
                Text("Fetching Data")
                    .foregroundColor(.secondary)
            }
            ProgressBar(progress: $progress)
                .onReceive(timer) { _ in
                    withAnimation {
                        self.progress = progressObjs
                            .map { $0.fractionCompleted }
                            .reduce(0, +) / Double(progressObjs.count)
                    }

                    if progressObjs.allSatisfy({$0.isFinished}) {
                        timer.upstream.connect().cancel()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                self.done = true
                            }
                        }
                    }
                }
            Text("Hang on...")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(15)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .frame(width: 300)
    }
}

struct ProgressBar: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Color.blaze.opacity(0.3)
                Color.blaze
                    .frame(width: geo.size.width*CGFloat(min(self.progress, 1.0)))
            }
            .frame(height: 4)
            .clipShape(RoundedRectangle(cornerRadius: 2, style: .continuous))
            .animation(Animation.spring(dampingFraction: 0.9), value: self.progress)
        }
        .frame(height: 4)
    }
}
