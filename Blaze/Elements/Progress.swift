//
//  ProgressBar.swift
//  Blaze
//
//  Created by Nathan Choi on 9/13/20.
//

import SwiftUI

struct ProgressBarView: View {
    
    static let index = [0, 1, 2, 3, 4, 5]
    
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
            VStack(alignment: .center, spacing: 39) {
                Image(systemName: "hand.tap")
                    .font(.title)
                    .foregroundColor(.blaze)
                
                Text("Using one finger, ")
                    .foregroundColor(Color(.tertiaryLabel))
                + Text("double tap and drag vertically ")
                    .foregroundColor(.blaze)
                    .fontWeight(.medium)
                + Text("to change map size.")
                    .foregroundColor(Color(.tertiaryLabel))
            }
        case 1:
            VStack(alignment: .center, spacing: 39) {
                Image(systemName: "heart")
                    .font(.title)
                    .foregroundColor(.blaze)
                
                Text("Developed and designed with ")
                    .foregroundColor(Color(.tertiaryLabel))
                + Text("love.")
                    .foregroundColor(.blaze)
                    .fontWeight(.medium)
            }
        case 2:
            VStack(alignment: .center, spacing: 39) {
                Image(systemName: "plus.rectangle.on.rectangle")
                    .font(.title)
                    .foregroundColor(.blaze)
                
                Text("Tap and hold on a ")
                    .foregroundColor(Color(.tertiaryLabel))
                + Text("Fire Card ")
                    .foregroundColor(.blaze)
                    .fontWeight(.medium)
                + Text("to pin it to ")
                    .foregroundColor(Color(.tertiaryLabel))
                + Text("Monitoring List.")
                    .foregroundColor(.blaze)
                    .fontWeight(.medium)
            }
        case 3:
            VStack(alignment: .center, spacing: 39) {
                Image(systemName: "square.and.arrow.up")
                    .font(.title)
                    .foregroundColor(.blaze)
                
                Text("Tap and hold on a ")
                    .foregroundColor(Color(.tertiaryLabel))
                + Text("News Card ")
                    .foregroundColor(.blaze)
                    .fontWeight(.medium)
                + Text("to ")
                    .foregroundColor(Color(.tertiaryLabel))
                + Text("share ")
                    .foregroundColor(.blaze)
                    .fontWeight(.medium)
                + Text("with other people.")
                    .foregroundColor(Color(.tertiaryLabel))
            }
        case 4:
            VStack(alignment: .center, spacing: 39) {
                Image(systemName: "lock.open")
                    .font(.title)
                    .foregroundColor(.blaze)
                
                Text("Blaze's code is ")
                    .foregroundColor(Color(.tertiaryLabel))
                + Text("open sourced ")
                    .foregroundColor(.blaze)
                    .fontWeight(.medium)
                + Text("on ")
                    .foregroundColor(Color(.tertiaryLabel))
                + Text("Github.")
                    .foregroundColor(.blaze)
                    .fontWeight(.medium)
            }
        case 5:
            VStack(alignment: .center, spacing: 39) {
                Image(systemName: "swift")
                    .font(.title)
                    .foregroundColor(.blaze)
                
                Text("Blaze is written in ")
                    .foregroundColor(Color(.tertiaryLabel))
                + Text("SwiftUI.")
                    .foregroundColor(.blaze)
                    .fontWeight(.medium)
            }
        default:
            VStack(alignment: .center, spacing: 39) {
                Image(systemName: "hand.tap")
                    .font(.title)
                    .foregroundColor(.blaze)
                
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
            .animation(Animation.spring(response: 0.39, dampingFraction: 0.9), value: self.progress)
        }
        .frame(width: 139, height: 5)
    }
}
