//
//  TextFormate.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-03-20.
//

import SwiftUI

struct TextFormate: View {
    
    @State var text: String = "Nockeby (Nockebybanan)"
    
    var body: some View {
        Text(text)
            
    }
}

struct TextFormate_Previews: PreviewProvider {
    static var previews: some View {
        TextFormate()
    }
}
