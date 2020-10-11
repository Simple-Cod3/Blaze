//
//  PhoneInfoView.swift
//  Blaze
//
//  Created by Nathan Choi on 10/10/20.
//

import SwiftUI
import MapKit

struct PhoneInfoView: View {
    @State private var coordinateRegion = MKCoordinateRegion()
    
    var dismiss: () -> ()
    var phoneData: PhoneNumber
    
    var phoneCircle: some View {
        ZStack {
            Color(.secondarySystemGroupedBackground)
            Color.blaze.opacity(0.3)
            
            Image(systemName: "phone.fill")
                .font(.system(size: 55))
                .foregroundColor(.blaze)
        }
        .frame(width: 120, height: 120)
        .clipShape(Circle())
        .shadow(color: Color.black.opacity(0.12), radius: 5, y: 2)
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                Color(.secondarySystemGroupedBackground).frame(height: UIScreen.main.bounds.maxY/2)
                    .offset(y: -UIScreen.main.bounds.maxY/1.5)
                
                VStack {
                    LazyVStack(spacing: 15) {
                        Spacer()
                        phoneCircle
                            .overlay(
                                Check(yes: true, interval: 0, size: 40).offset(x: 45, y:-45)
                            )
                        
                        VStack {
                            Text(cleanTitle)
                                .font(cleanTitle.count > 20 ? .title : .largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                            Text(phoneData.county ?? "County Name")
                                .font(.callout)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(height: UIScreen.main.bounds.maxY/2.4)
                    .background(Color(.secondarySystemGroupedBackground))
                    
                    Spacer()
                    
                    TabView {
                        LazyVStack {
                            Text(phoneData.phoneNumber ?? "### ###-####")
                                .font(.system(.largeTitle, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(.blaze)
                            HStack(spacing: 20) {
                                Image(systemName: "phone.fill.arrow.up.right")
                                    .font(.system(size: 35))
                                    .foregroundColor(.green)
                                    .padding(20)
                                    .background(Color(.secondarySystemGroupedBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                
                                Image(systemName: "person.crop.circle.badge.plus")
                                    .font(.system(size: 35))
                                    .foregroundColor(.blue)
                                    .padding(20)
                                    .background(Color(.secondarySystemGroupedBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            }.padding(20)
                            Spacer()
                        }
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .padding(20)
                        
                        if let lat = phoneData.lat, let long = phoneData.long {
                            Map(coordinateRegion: $coordinateRegion)
                                .frame(width: UIScreen.main.bounds.maxX-40, height: 230)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                .padding([.horizontal, .bottom], 20)
                                .allowsHitTesting(false)
                                .onAppear {
                                    self.coordinateRegion = MKCoordinateRegion(
                                        center: .init(latitude: lat, longitude: long),
                                        span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                    )
                                }
                        }
                    }
                    .frame(height: 300)
                    .tabViewStyle(PageTabViewStyle())
                    
                    Spacer()
                }
            }
        }
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .navigationBarItems(trailing: Button(action: dismiss) {
            CloseModalButton()
        })
    }
    
    var closed: Bool { phoneData.name!.contains(" CLOSED") }
    var cleanTitle: String { phoneData.name!.replacingOccurrences(of: " CLOSED", with: "")}
}
