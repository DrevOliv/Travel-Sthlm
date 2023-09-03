//
//  Auto_ResaApp.swift
//  Auto Resa
//
//  Created by Oliver Drevet on 2022-02-23.
//

import SwiftUI

@main
struct Auto_ResaApp: App {
    
    @Environment(\.locationstate) var Locatiostate
    
    @StateObject var vmCoreData = CoreDataManager()
    @StateObject var tabselection = TAB()
    
    var body: some Scene {
        WindowGroup {

//            GetSymbol()
//            test()
//            TestListSwipe()
            
            
//            Scrool_index_()
            
//                SwiftUIView()
//            TestView()
                ContentView()
                .environmentObject(vmCoreData)
                .environmentObject(tabselection)

            
            
            
            
//            Visa_Redigera().environmentObject(vmCoreData)
            
//            ListVisaResorModel()
            
//            VisaResorModelView()
//            VisaResor().environmentObject(vmCoreData)
        }
    }
}
