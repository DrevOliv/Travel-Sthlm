//
//  SkapaStationSamling.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-03-11.
//

import SwiftUI

struct SkapaStationSamling: View {
    
    @EnvironmentObject var vmCoreData: CoreDataManager
    
    @State var ButtonStation1: String = "Avgång"
    @State var ButtonStation2: String = "Destination"
    
    @State var AvgångsSheet = false
    @State var DestinationSheet = false
    
    @State var AvgångsID: String = "Inget"
    @State var AvgångsNamn: String = "Avgång"
    
    
    @State var DestinationID: String = "Inget"
    @State var DestinationsNamn: String = "Destination"
    
    @State var kanSpara = false
    
    @Binding var SpakaResaNav: Bool
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 50){
                Text("")
                Spacer()
                        Button(action: {AvgångsSheet.toggle()}) {
                            
                            Text("\(ButtonStation1)")
                                .foregroundColor(Color.blue)
                                .padding()
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.3)))
                            
                        }.sheet(isPresented: $AvgångsSheet, onDismiss: {
                            if AvgångsNamn == "Inget" {
                                ButtonStation1 = "Avgång"
                            } else {
                                ButtonStation1 = AvgångsNamn
                            }
                        }) {
                            So_k_Station(ShowingSheet: $AvgångsSheet, StationID: $AvgångsID, StationNamn: $AvgångsNamn)}
                        .onChange(of: AvgångsNamn) { newValue in
                            ChecKanSpara()
                        }
                        
                    
                        HStack{
                            Spacer()
                        Image(systemName: "arrow.down")
                            .imageScale(.large)
                            Spacer()
                        }
                        
                    
                        

                    
                        Button(action: {DestinationSheet.toggle()}) {
                            
                            Text("\(ButtonStation2)")
                                .foregroundColor(Color.blue)
                                .padding()
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.3)))
                            
                        }.sheet(isPresented: $DestinationSheet, onDismiss: {
                            
                            if DestinationsNamn == "Inget" {
                                ButtonStation2 = "Destination"
                            } else {
                                ButtonStation2 = DestinationsNamn
                            }
                            
                        }) {
                            So_k_Station(ShowingSheet: $DestinationSheet, StationID: $DestinationID, StationNamn: $DestinationsNamn)}
                        .onChange(of: DestinationsNamn) { newValue in
                            ChecKanSpara()
                        }
                   
                Spacer()
                Button("Spara") {
                    if (kanSpara){
                        SparaStat()
                        SpakaResaNav.toggle()
                    } else {
                        return
                    }
                }
                
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 10).fill(kanSpara ? Color.blue : Color.gray))
                .padding()
                .padding()
                    
                
            }
            
        }
        .navigationBarTitle("Skapa Resa")
        
        
    }
        
    func SparaStat(){
        print("ID Avgång: \(AvgångsID), ID Destination: \(DestinationID)")
        vmCoreData.addStationer(AvgångSta: AvgångsNamn, AvgångStaID: AvgångsID, DestinationSta: DestinationsNamn, DestinationStaID: DestinationID)
        HapticManager.instance.impact(style: .soft)
    }
    
    func ChecKanSpara() {
        if (AvgångsNamn != "Avgång" && DestinationsNamn != "Destination" && AvgångsNamn != DestinationsNamn){
            kanSpara = true
            
        } else {
            kanSpara = false
        }
    }
}

struct SkapaStationSamling_Previews: PreviewProvider {
    
    @State static var show: Bool = false
    
    static var previews: some View {
        SkapaStationSamling(SpakaResaNav: $show)
    }
}
