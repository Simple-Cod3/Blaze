//
//  Check.swift
//  Blaze
//
//  Created by Nathan Choi on 10/3/20.
//

import SwiftUI

struct Check: View {
    
    @State var yes: Bool
        
    init(yes: Bool) {
        self._yes = State(initialValue: yes)
    }
    
    var body: some View {
        if yes {
            SymbolButton("xmark")
        } else {
            SymbolButton("chevron.right")
        }
    }
}
