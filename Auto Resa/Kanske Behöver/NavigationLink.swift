//
//  NavigationLink.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-05-28.
//

import SwiftUI

struct Navigationlink: View {
    var body: some View {
        VStack{
            NavigationLink(destination: {Text("hejhhshfjdfjdfjd")}) {
                Text("Gå Till NavLink")
            }
            
        }
    }
}

struct NavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        Navigationlink()
    }
}
