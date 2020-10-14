//
//  SplashScreen.swift
//  Blaze
//
//  Created by Nathan Choi on 9/8/20.
//

import SwiftUI

struct SplashScreen: View {
    @AppStorage("areaUnits") var areaUnits: String = currentUnit ?? units[0]
    @Binding var show: Bool
    @State var page = 0
    
    private func areaScale(_ areaUnits: String) -> CGFloat {
        let i = units.firstIndex(of: areaUnits)
        
        if i == 0 { return 0.1 }
        if i == 1 { return 1 }
        return 2
    }
    
    // MARK: - SplashScreen Section View
    
    /// Splashsceen specifc struct
    private struct Section: View {
        var icon: String
        var title: String
        var p: String
        
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
                    Text(p)
                        .font(.subheadline)
                }
            }
        }
    }
    private struct InfoBubble: View {
        var text: String
        
        var body: some View {
            Text(text)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(20)
                .background(Color.blaze)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .overlay(
                    Circle()
                        .fill(Color.blaze.opacity(0.3))
                        .frame(width: 20, height: 20)
                        .offset(x: 17, y: 17)
                    ,
                    alignment: .bottomTrailing)
                .padding(.vertical, 40)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    // MARK: - Main SplashScreen View
    
    var pageOne: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Image("fire").resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 80)
            Text("Welcome to ")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Blaze: CA Wildfires")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blaze)
            
            Spacer()
            
            Button(action: { page = 1 }) {
                HStack {
                    Spacer()
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                }
                .padding(15)
                .background(Color.blaze)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }.padding(.vertical, 40)
        }.padding(.horizontal, 20)
    }
    var pageTwo: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            InfoBubble(text: "Latest fire information prepared for you.")
            
            Header(title: "Wildfires", padding: 0)
            Text("Uncontrollable fires that spreads quickly over vegetation in rural areas. The scale of destruction is largely driven by weather conditions.")
                .redacted(reason: .placeholder)
                .padding(.bottom, 20)
            
            HStack(spacing: 20) {
                HStack {
                    Spacer()
                    Text("\(Image(systemName: "map")) Fire Map")
                        .fontWeight(.medium)
                        .foregroundColor(.blaze)
                    Spacer()
                }
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                HStack {
                    Spacer()
                    Text("\(Image(systemName: "map")) Fire Map")
                        .fontWeight(.medium)
                        .foregroundColor(.blaze)
                    Spacer()
                }
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }.redacted(reason: .placeholder)
            
            Spacer()
            Button(action: { page = 2 }) {
                HStack {
                    Spacer()
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                }
                .padding(15)
                .background(Color.blaze)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding(.vertical, 40)
        }
        .padding(.horizontal, 20)
    }
    var pageThree: some View {
        VStack(alignment: .leading) {
            Spacer()
            InfoBubble(text: "Real-time local air quality.")
            
            LazyVStack {
                ZStack {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 100, height: 100)
                    Text("Good").redacted(reason: .placeholder)
                }
            }
            
            Header(title: "Air Quality", headerColor: .green, padding: 0)
            Text("Real-time local air quality. Real-time local air quality. Real-time local air quality. Real-time local air quality.")
                .redacted(reason: .placeholder)
            
            Spacer()
            
            Button(action: { page = 3 }) {
                HStack {
                    Spacer()
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                }
                .padding(15)
                .background(Color.blaze)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }.padding(.vertical, 40)
        }
        .padding(.horizontal, 20)
    }
    var pageFour: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            InfoBubble(text: "News and updates at your fingertips.")
                .padding(.horizontal, 20)
            
            Header(title: "News", padding: 0)
                .padding(.horizontal, 20)
            Text("Real-time local air quality. Real-time local air quality.")
                .redacted(reason: .placeholder)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    HorizontalCard(title: "Emergency Contacts", subtitle: "Find the nearest fire stations")
                    HorizontalCard(title: "Glossary", subtitle: "Learn wildfire terms")
                }
                .padding(.horizontal, 20)
            }
            
            Spacer()
            
            Button(action: { page = 4 }) {
                HStack {
                    Spacer()
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                }
                .padding(15)
                .background(Color.blaze)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 20)
        }
    }
    var pageFive: some View {
        VStack {
            Spacer()
            
            ZStack {
                Circle().fill(Color.blaze.opacity(0.7))
                    .frame(width: 120, height: 120)
                    .scaleEffect(areaScale(areaUnits))
                    .animation(.spring())
                
                Circle().fill(Color.blaze)
                    .frame(width: 100, height: 100)
                    .scaleEffect(areaScale(areaUnits))
                    .animation(.spring(dampingFraction: 0.3))
            }
            
            Spacer()
            
            UnitsCard(title: "Units", desc: "Set the units of measurement for area.")
                .offset(y: page == 4 ? 0 : UIScreen.main.bounds.maxY)
                .opacity(page == 4 ? 1 : 0)
            
            Button(action: { show = false }) {
                HStack {
                    Spacer()
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                }
                .padding(15)
                .background(Color.blaze)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 20)
            .zIndex(5)
        }
    }
    
    var body: some View {
        ZStack {
            pageOne
                .offset(x: -UIScreen.main.bounds.maxX*CGFloat(page))
            pageTwo
                .offset(x: -UIScreen.main.bounds.maxX*CGFloat(page - 1))
            pageThree
                .offset(x: -UIScreen.main.bounds.maxX*CGFloat(page - 2))
            pageFour
                .offset(x: -UIScreen.main.bounds.maxX*CGFloat(page - 3))
            pageFive
                .offset(x: -UIScreen.main.bounds.maxX*CGFloat(page - 4))
            
            if page > 0 {
                HStack {
                    VStack {
                        Button(action: { if page > 0 {page -= 1} }) {
                            Image(systemName: "arrow.backward.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    Spacer()
                }.padding(20)
                .transition(.move(edge: .leading))
            }
        }
        
        .animation(.spring(), value: page)
    }
}

// MARK: - Previews

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(show: .constant(true))
            
    }
}
