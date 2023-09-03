//
//  MainTab.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-03-11.
//

import SwiftUI

class TAB: ObservableObject {
    
    @Published var TabSelection: Tabse = .VisaResor
    
    enum Tabse {
        case VisaResor, ShowCoordinate
    }
    
}




struct MainTab: View {
    
    @EnvironmentObject var tabselection: TAB
    
    var body: some View {

        VStack{
            switch tabselection.TabSelection {
            
        case .VisaResor:
                    VisaResor()

            
        case .ShowCoordinate:
                NavigationView {
                    VStack(spacing: 0){
                    ShowCordinates()
                    Tabview()

                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
            
        }
            
        }
    }
}

