//
//  SplashScreen.swift
//  Blaze
//
//  Created by Nathan Choi on 9/8/20.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var show: Bool
    
    // MARK: - SplashScreen Section View
    
    /// Splashsceen specifc struct
    private struct Section: View {
        var icon: String
        var title: String
        var p: String
        
        var body: some View {
            HStack(alignment: .top, spacing: 20) {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blaze.opacity(0.5), .blaze]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .mask(
                    Image(systemName: icon)
                        .font(.system(size: 40))
                ).frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text(p)
                        .font(.subheadline)
                }
            }
        }
    }
    
    // MARK: - Main SplashScreen View
    
    var body: some View {
        /// First Section
        LazyVStack(alignment: .leading) {
            Text("Welcome to ")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Blaze: CA Wildfires")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blaze)
            
            Spacer().frame(height: 40)
            
            LazyVStack(alignment: .leading, spacing: 40) {
                Section(
                    icon: "newspaper.fill",
                    title: SplashScreenContants.news.title,
                    p: SplashScreenContants.news.p
                )
                
                Section(
                    icon: "flame.fill",
                    title: SplashScreenContants.fires.title,
                    p: SplashScreenContants.fires.p
                )
                
                Section(
                    icon: "magnifyingglass",
                    title: SplashScreenContants.search.title,
                    p: SplashScreenContants.search.p
                )
                
                Spacer()
                Button(action: { show.toggle() }) {
                    HStack {
                        Spacer()
                        Text("Continue")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                    }
                    .padding(15)
                    .background(Color.blaze)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
        .padding(.horizontal, 20)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

// MARK: - Previews

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(show: .constant(true))
    }
}
