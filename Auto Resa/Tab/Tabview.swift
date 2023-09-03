//
//  Tabview.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-06-09.
//

import SwiftUI

struct Tabview: View {
    
    var body: some View {
        
        HStack {
            
            TabviewIcon(symbol: "location.fill", name: "Planerad Resa", selector: .VisaResor)
            TabviewIcon(symbol: "location.magnifyingglass", name: "Stationer", selector: .ShowCoordinate)
        }
        
        .padding(.top)
        
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(color: Color.gray, radius: 1, x: 0, y: 0).opacity(0.5).edgesIgnoringSafeArea(.bottom))
    }
    
}


struct TabviewIcon: View {
    
    @EnvironmentObject var tabselection: TAB
    
    let symbol, name: String
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    let selector: TAB.Tabse
    
    var body: some View {
        VStack {
            Image(systemName: symbol)
            Text(name)
        }
        .onTapGesture {
            tabselection.TabSelection = selector
        }
        .foregroundColor(tabselection.TabSelection == selector ? Color.blue : Color.gray)
        
        .frame(maxWidth: .infinity)
    }
}








struct Tabview_Previews: PreviewProvider {
    static var previews: some View {
        Tabview()
    }
}
