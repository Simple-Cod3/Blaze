//
//  PhoneView.swift
//  Blaze
//
//  Created by Max on 9/27/20.
//

import SwiftUI

struct PhoneView: View {
    @EnvironmentObject var numbers: PhoneBackend
    
    @State var showNum = 20
    var dismiss: () -> ()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer().frame(height: 200)
                    
                    Group {
                        VStack(spacing: 20) {
                            ForEach(
                                numbers.numbers.prefix(showNum)
                            ) { number in
                                NavigationLink (destination: Text("Test")) {
                                    HStack(alignment: .top) {
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(number.name?.replacingOccurrences(of: " CLOSED", with: "") ?? "Unknown Name")
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            HStack(spacing: 10) {
                                                if let county = number.county {
                                                    Text(county)
                                                }
                                                Text(number.phoneNumber!)
                                                Spacer()
                                            }.foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        if number.name!.contains(" CLOSED") {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color.red.opacity(0.7))
                                        } else {
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color.green.opacity(0.7))
                                        }
                                    }
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                }
                            }
                        }.padding(.vertical, 10)
                    }
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .padding(20)
                
                    
                    if numbers.numbers.count > showNum {
                        Button(action: {
                            showNum += 20
                        }) {
                            Text("\(Image(systemName: "rectangle.stack.fill.badge.plus")) Show More")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.vertical, 7)
                                .padding(.horizontal, 10)
                                .background(Color.blaze)
                                .clipShape(Capsule())
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .background(Color(.tertiarySystemGroupedBackground).edgesIgnoringSafeArea(.bottom))
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: dismiss) {
                    CloseModalButton()
                }
            )
        }
    }
}
