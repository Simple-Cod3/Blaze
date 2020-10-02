//
//  PhoneView.swift
//  Blaze
//
//  Created by Max on 9/27/20.
//

import SwiftUI

struct PhoneView: View {
    @EnvironmentObject var numbers: PhoneBackend
    
    var body: some View {
        ForEach(numbers.numbers[0].features){ number in
            Text(number.attributes.phoneNumber ?? "unknown")
        }
    }
}
