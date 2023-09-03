//
//  ContentView.swift
//  Auto Resa
//
//  Created by Oliver Drevet on 2022-02-23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.locationstate) var Locatiostate
    
    @ObservedObject var locationManager = LocationManager.shered
    @State var showSettings = false
    
    var body: some View {
        
        
        Group{
            switch Locatiostate {
                case 0: EmptyView()
                case 1: OpenSettings()
                case 2: OpenSettings()
                case 3: MainTab()
                case 4: MainTab()
                case 5: OpenSettings()
                case 6: OpenSettings()
                case 7: EmptyView()
                default: EmptyView()
            }
        }.onAppear {
            locationManager.requestLocation()
            print("Locatiostate")
            print(Locatiostate)
            
        }
        
        
        
        
        //        Group{
        //
        //
        //            if (locationManager.userlocation == nil) {
        //
        //
        //
        //                if !showSettings {
        //                    Text("")
        //                        .onAppear {
        //                            print("Delay")
        //                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
        //                                withAnimation {
        //                                    showSettings.toggle()
        //                                }
        //
        //                            })
        //                        }
        //                }
        //
        //                else if showSettings {
        //                    OpenSettings()
        //                }
        //            }
        //
        //            else {
        //                MainTab()
        //            }
        //
        //        }.onAppear {
        //            locationManager.requestLocation()
        //            print("Locatiostate")
        //            print(Locatiostate)
        //        }
        //        .onChange(of: Locatiostate) { value in
        //            print(Locatiostate)
        //        }
    }
    
    
    
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
