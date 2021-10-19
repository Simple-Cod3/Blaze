//
//  ProgressBar.swift
//  Blaze
//
//  Created by Nathan Choi on 9/13/20.
//

import SwiftUI

struct ProgressBarView: View {
    
    static let index = [0, 1]
    
    @Binding var progressObjs: [Progress]
    @Binding var progress: Double
    @Binding var done: Bool
    
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var randomIndex: Int = index.randomElement()!
        
    var body: some View {
        VStack(alignment: .center, spacing: 39) {
            Spacer()
            
            HStack {
                Spacer()
                
                SplashText(randomIndex)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 80)
                
                Spacer()
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
        
            Spacer()
        }
        .background(
            RegularBlurBackground()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct SplashText: View {
    
    private var index: Int
    
    init(_ index: Int) {
        self.index = index
    }

    var body: some View {
        switch index {
        case 0:
            Text("Using one finger, ")
                .foregroundColor(Color(.tertiaryLabel))
            + Text("double tap and drag vertically ")
                .foregroundColor(.blaze)
                .fontWeight(.medium)
            + Text("to change map size.")
                .foregroundColor(Color(.tertiaryLabel))
        case 1:
            Text("Developed and designed with ")
                .foregroundColor(Color(.tertiaryLabel))
            + Text("love.")
                .foregroundColor(.blaze)
                .fontWeight(.medium)
        default:
            Text("Using one finger, ")
                .foregroundColor(Color(.tertiaryLabel))
            + Text("double tap and drag vertically ")
                .foregroundColor(.blaze)
                .fontWeight(.medium)
            + Text("to change map size.")
                .foregroundColor(Color(.tertiaryLabel))
        }
    }
}

struct ProgressBar: View {
    
    @Binding var progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Color(.quaternarySystemFill)
                Color.blaze
                    .frame(width: geo.size.width*CGFloat(min(self.progress, 1.0)))
                    .clipShape(RoundedRectangle(cornerRadius: 39, style: .continuous))
            }
            .frame(height: 5)
            .clipShape(RoundedRectangle(cornerRadius: 39, style: .continuous))
            .animation(Animation.spring(dampingFraction: 0.9), value: self.progress)
        }
        .frame(width: 139, height: 5)
    }
}
