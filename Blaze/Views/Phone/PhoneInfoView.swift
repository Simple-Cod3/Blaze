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
    @State private var pastedState = false
    @State private var viewMode = 0
    
    var dismiss: () -> Void
    var phoneData: PhoneNumber
    
    var phoneCircle: some View {
        ZStack {
            Color(.secondarySystemBackground)
            
            Image(systemName: "building.2.fill")
                .font(.system(size: 55))
                .foregroundColor(closed ? .red : .green)
        }
        .frame(width: 120, height: 120)
        .clipShape(Circle())
        .shadow(color: Color.black.opacity(0.12), radius: 10, y: 5)
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
                                Check(yes: closed, interval: 0, size: 40).offset(x: 45, y: -45)
                            )
                        
                        VStack(spacing: 15) {
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
                    
                    Picker("", selection: $viewMode) {
                        Text("Contact").tag(0)
                        Text("Map").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.top, .horizontal], 20)
                    
                    ZStack {
                        LazyVStack {
                            Text(phoneData.phoneNumber ?? "Unknown Number")
                                .font(.system(.largeTitle, design: .rounded))
                                .fontWeight(.bold)
                            HStack(spacing: 20) {
                                Button(action: {
                                    let url = URL(string: "tel://" + cleanNum)!
                                    UIApplication.shared.open(url)
                                }) {
                                    Image(systemName: "phone.fill.arrow.up.right")
                                        .font(.system(size: 35))
                                        .foregroundColor(.green)
                                        .padding(20)
                                        .background(Color(.secondarySystemGroupedBackground))
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                }
                                Button(action: {
                                    UIPasteboard.general.string = cleanNum
                                    pastedState = true
                                }) {
                                    Image(systemName: "doc.on.clipboard")
                                        .font(.system(size: 30))
                                        .foregroundColor(pastedState ? .blue : .secondary)
                                        .padding(18)
                                        .background(Color(.secondarySystemGroupedBackground))
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                }
                            }.padding(20)
                            Spacer()
                        }
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .padding(20)
                        .offset(x: -UIScreen.main.bounds.maxX*CGFloat(viewMode))
                        
                        if let lat = phoneData.lat, let long = phoneData.long {
                            Map(
                                coordinateRegion: $coordinateRegion,
                                annotationItems: [phoneData]
                            ) { _ in
                                MapPin(
                                    coordinate: CLLocationCoordinate2D(
                                        latitude: lat,
                                        longitude: long
                                    )
                                )
                            }
                            .frame(height: 230)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .padding([.horizontal, .bottom], 20)
                            .offset(x: -UIScreen.main.bounds.maxX*CGFloat((viewMode - 1)))
                            .onAppear {
                                self.coordinateRegion = MKCoordinateRegion(
                                    center: .init(latitude: lat, longitude: long),
                                    span: .init(latitudeDelta: 0.08, longitudeDelta: 0.08)
                                )
                            }
                            .onChange(of: viewMode) { value in
                                if value == 1 {
                                    self.coordinateRegion = MKCoordinateRegion(
                                        center: .init(latitude: lat, longitude: long),
                                        span: .init(latitudeDelta: 0.08, longitudeDelta: 0.08)
                                    )
                                }
                            }
                        } else {
                            Text("\(Image(systemName: "exclamationmark.triangle")) Location Unavailble")
                                .font(.headline)
                                .foregroundColor(.yellow)
                        }
                    }
                    .animation(.spring(), value: viewMode)
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
        .onAppear {
            pastedState = pasted
        }
    }
    
    var closed: Bool { phoneData.name!.contains(" CLOSED") }
    var cleanTitle: String { phoneData.name!.replacingOccurrences(of: " CLOSED", with: "")}
    var cleanNum: String { phoneData.phoneNumber ?? "".replacingOccurrences(of: "-", with: "")}
    var pasted: Bool { UIPasteboard.general.string == cleanNum }
}
