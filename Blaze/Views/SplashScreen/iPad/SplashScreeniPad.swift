//
//  SplashScreeniPad.swift
//  Blaze
//
//  Created by Paul Wong on 11/2/20.
//

import SwiftUI

struct SplashScreeniPad: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("areaUnits") var areaUnits: String = currentUnit ?? units[0]
    @Binding var show: Bool
    @State var page = 0
    
    private func areaScale(_ areaUnits: String) -> CGFloat {
        let index = units.firstIndex(of: areaUnits)
        
        if index == 0 { return 0.1 }
        if index == 1 { return 1 }
        return 2
    }
    
    // MARK: - SplashScreen Section View
    
    /// Splashsceen specifc struct
    private struct Section: View {
        var icon: String
        var title: String
        var paragraph: String
        
        var body: some View {
            HStack(alignment: .top, spacing: 20) {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blaze.opacity(0.8), .blaze]),
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
                    Text(paragraph)
                        .font(.subheadline)
                }
            }
        }
    }
    
    private struct InfoBubble: View {
        var text: String
        
        var body: some View {
            VStack(alignment: .trailing) {
                Text(text)
                    .foregroundColor(.white)
                    .padding(15)
                    .background(Color.blaze)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding(.vertical, 40)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    // MARK: - Main SplashScreen View
    
    var page1: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Image("appicon").resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 75)
                .cornerRadius(20)
            Text("Welcome to ")
                .font(.largeTitle)
                .fontWeight(.medium)
            Text("Blaze: CA Wildfires")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.blaze)
            
            Spacer()
            
            Button(action: { page = 1 }) {
                LongButton("Next")
            }
        }
        .padding([.horizontal, .bottom], 20)
    }
    var page2: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Spacer()
                InfoBubble(text: "Latest fire information prepared for you.")
            }
                   
            HStack {
                VStack {
                    Header(title: "Wildfires", padding: 0)
                    Text("Uncontrollable fires that spreads quickly over vegetation in rural areas. The scale of destruction is largely driven by weather conditions.")
                        .redacted(reason: .placeholder)
                        .padding(.bottom, 20)
                    
                    HStack(spacing: 20) {
                        HStack {
                            Spacer()
                            Text("Fire Map")
                                .fontWeight(.medium)
                                .foregroundColor(.blaze)
                            Spacer()
                        }
                        .padding(12)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        HStack {
                            Spacer()
                            Text("Fire Map")
                                .fontWeight(.medium)
                                .foregroundColor(.blaze)
                            Spacer()
                        }
                        .padding(12)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .redacted(reason: .placeholder)
                }
                .frame(width: 275)
                
                Spacer()
                
                HStack(spacing: 20) {
                    VStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Image(systemName: "flame")
                                .font(.system(size: 26))
                                .padding(.bottom, 10)
                                .foregroundColor(.secondary)
                                .redacted(reason: .placeholder)
                            
                            Text("August Complex")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                                .redacted(reason: .placeholder)
                            
                            Spacer()
                            HStack {
                                Text("10,000 Acres")
                                    .foregroundColor(.blaze)
                                    .redacted(reason: .placeholder)
                                Spacer()
                                
                                RoundedButton("MAP")
                                    .redacted(reason: .placeholder)
                            }
                        }
                        .padding(15)
                        .frame(width: 160, height: 140)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    
                    VStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Image(systemName: "flame")
                                .font(.system(size: 26))
                                .padding(.bottom, 10)
                                .foregroundColor(.secondary)
                                .redacted(reason: .placeholder)
                            
                            Text("August Complex")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                                .redacted(reason: .placeholder)
                            
                            Spacer()
                            HStack {
                                Text("10,000 Acres")
                                    .foregroundColor(.blaze)
                                    .redacted(reason: .placeholder)
                                Spacer()
                                
                                RoundedButton("MAP")
                                    .redacted(reason: .placeholder)
                            }
                        }
                        .padding(15)
                        .frame(width: 160, height: 140)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                }
            }
            
            Spacer()
            Button(action: { page = 2 }) {
                LongButton("Next")
            }
        }
        .padding([.horizontal, .bottom], 20)
    }
    var page3: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Spacer()
                InfoBubble(text: "Real-time local air quality.")
            }
            
            HStack {
                VStack {
                    Header(title: "Air Quality", headerColor: .green, padding: 0)
                    Text("Real-time local air quality. Real-time local air quality. Real-time local air quality.")
                        .redacted(reason: .placeholder)
                }
                .frame(width: 250)
                
                Spacer()
                
                LazyVStack {
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 250, height: 250)
                        VStack(alignment: .center) {
                            Text("Good").redacted(reason: .placeholder)
                                .font(.largeTitle)
                            Text("Good").redacted(reason: .placeholder)
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: { page = 3 }) {
                LongButton("Next")
            }
        }
        .padding([.horizontal, .bottom], 20)
    }
    var page4: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Spacer()
                InfoBubble(text: "News and updates at your fingertips.")
                    .padding(.trailing, 20)
            }
            
            HStack {
                VStack {
                    Header(title: "News", padding: 0)
                    Text("Real-time local air quality. Real-time local air quality.")
                        .redacted(reason: .placeholder)
                    
                    HStack(spacing: 20) {
                        HorizontalCardRedactediPad(title: "Glossary", subtitle: "Learn")
                            .frame(width: 140)
                            .redacted(reason: .placeholder)
                        HorizontalCardRedactediPad(title: "Glossary", subtitle: "Learn")
                            .frame(width: 140)
                            .redacted(reason: .placeholder)
                    }
                }
                .frame(width: 300)
                .padding(.leading, 20)
                
                Spacer()
                
                VStack(spacing: 20) {
                    NewsCardRedactediPad()
                    NewsCardRedactediPad()
                }
                .redacted(reason: .placeholder)
            }
            
            Spacer()
            
            Button(action: { page = 4 }) {
                LongButton("Next")
            }
            .padding([.horizontal, .bottom], 20)
        }
    }
    var page5: some View {
        VStack {
            Spacer()
            
            ZStack {
                Circle().fill(Color.blaze.opacity(0.7))
                    .frame(width: 120, height: 120)
                    .scaleEffect(areaScale(areaUnits))
                    .animation(.spring(response: 1), value: areaUnits)
                
                Circle().fill(Color.blaze)
                    .frame(width: 100, height: 100)
                    .scaleEffect(areaScale(areaUnits))
                    .animation(.spring(response: 1.5), value: areaUnits)
            }
            .opacity(page == 4 ? 1 : 0)
            
            Spacer()
            
            UnitsCard(title: "Units", desc: "Set the units of measurement for area.")
                .offset(y: page == 4 ? 0 : UIScreen.main.bounds.maxY)
                .opacity(page == 4 ? 1 : 0)
                .padding(.horizontal, 20)
            
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                LongButton("Close")
            }
            .padding(20)
            .zIndex(5)
        }
    }
    
    var body: some View {
        let screen = UIScreen.main.bounds
        
        return ZStack {
            page1.offset(x: -screen.maxX*CGFloat(page))
            page2.offset(x: -screen.maxX*CGFloat(page - 1))
            page3.offset(x: -screen.maxX*CGFloat(page - 2))
            page4.offset(x: -screen.maxX*CGFloat(page - 3))
            page5.offset(x: -screen.maxX*CGFloat(page - 4))
            
            if page > 0 {
                HStack {
                    VStack {
                        Button(action: { if page > 0 { page -= 1 } }) {
                            Image(systemName: "arrow.backward.circle.fill")
                                .font(.title)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(20)
                .transition(.move(edge: .leading))
            }
        }
        .animation(.spring(), value: page)
    }
}
