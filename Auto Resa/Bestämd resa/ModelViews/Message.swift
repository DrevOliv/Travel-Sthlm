//
//  Message.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-04-04.
//

import SwiftUI

struct Message: View {
    
    @State var text: String = ""
    
    var body: some View {
        if text != "" {
            Text(text)
                
        } else {
            EmptyView()
        }
        
    }
}

struct Message_Previews: PreviewProvider {
    static var previews: some View {
        Message()
    }
}
