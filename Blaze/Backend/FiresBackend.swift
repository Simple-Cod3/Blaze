//
//  FiresBackend.swift
//  Blaze
//
//  Created by Nathan Choi on 9/2/20.
//

import Foundation
import SwiftUI

class FireBackend: ObservableObject {
    @Published var fires = [ForestFire]()
    
    init() {
    
    }
}
