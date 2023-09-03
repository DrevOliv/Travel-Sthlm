//
//  Sök Station.swift
//  tutorial meme widget app
//
//  Created by Oliver Drevet on 2022-01-13.
//

import SwiftUI

struct So_k_Station: View {
    
    @EnvironmentObject var vmCoreData: CoreDataManager
    
    var api = Api()
    
    @Binding var ShowingSheet: Bool
    @Binding var StationID: String
    @Binding var StationNamn: String
    
    @State var station: Stationer_Sök?
    
    @State var Sökord = ""
    @State var FörraOrdet = ""
    
    @State var loading = false
    @State var EttFel = false
    @State var Cancel = false
    
    @State var HarSöktEnGång = false
    
    @State var IngaStationerPaNamn = false
    
    @State var SelectedFromMap: Bool = false
    
    var body: some View {
        
        NavigationView{
            Group{
                Form {
                    
                    Section {
                        List {
                            ForEach(vmCoreData.savedStationer){ index in
                                ListView(title: index.avgang ?? "", id: index.avgangid ?? "", selectedItem: $StationNamn, stationID: $StationID)
                            }
                            ForEach(vmCoreData.savedStationer){ index in
                                ListView(title: index.destination ?? "", id: index.destinationid ?? "", selectedItem: $StationNamn, stationID: $StationID)
                            }

                        }
                        NavigationLink {
                            StationerNara(SelectedName: $StationNamn, SelectedId: $StationID, SelectedFromMap: $SelectedFromMap)
                        } label: {
                            HStack {
                                Text("Stationer Nära Dig")
                                    .fixedSize(horizontal: true, vertical: true)
                                Image(systemName: "location.fill")
                                Spacer()
                                HStack{
                                    if StationNamn != "Avgång" &&  StationNamn != "Destination" && StationNamn != "Inget" && SelectedFromMap {
                                        Text(StationNamn)
                                    }
                                }.lineLimit(1)
                                

                            }
                            
                            .foregroundColor(Color.white)

                        
                    
                    }.listRowBackground(Color.blue)
                    }
                        
                    
                    Section {
                        HStack {
                            TextField("Sök Station", text: $Sökord)

                            Button(action: { Sök_stationer()}) {
                                Image(systemName: "magnifyingglass")
                            }
                        }
                    }
                    if (loading) {
                        HStack{
                            Spacer()
                            ProgressView()
                            
                            Spacer()
                        }                                .listRowBackground(Color.green.opacity(0))
                        
                    } else {
                        Section{
                            
                            if (!(station?.ResponseData.isEmpty ?? true)){
                                List(station?.ResponseData ?? []){station in
                                    ListView(title: station.Name ?? "", id: station.SiteId ?? "", selectedItem: $StationNamn, stationID: $StationID)
                                    
                                }
                            } else if (HarSöktEnGång && (station?.ResponseData.isEmpty ?? true)) {
                                Text("Hunde inte hitta stationen")
                            } else if (IngaStationerPaNamn) {
                                Text("Ingena stationer med namnet \(Sökord) hittades")
                                    .listRowBackground(Color.green.opacity(0))
                            }
                            
                            
                        }
                        
                        
                    }
                    
                }
                .navigationTitle("Sök Station")
                .toolbar{
                    Image(systemName: "x.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(Color.blue)
                        .onTapGesture(perform: {ShowingSheet.toggle()})
                }
                
                .alert("Ett Fel Inträffade", isPresented: $EttFel) {
                    HStack{
                        Button("Pröva Igen") {
                            Sök_stationer()
                        }
                        Button("Avbryt") {Cancel = true}
                    }
                }
                
            }
            
        }
        .onChange(of: Sökord) { Value in
            if Value.count > FörraOrdet.count {
                Sök_stationer()
                FörraOrdet = Value
            } else if Value.count < FörraOrdet.count {
                
                FörraOrdet = Value
                return
            }
            
        }
    }
    
    func Sök_stationer() {
        if (Sökord.isEmpty != true){
            loading = true
            api.getStationer_Sök(station: Sökord) { station in
                if station.ResponseData.isEmpty {
                    IngaStationerPaNamn = true
                    loading = false
                } else {
                    self.station = station
                    loading = false
                }
            }
        } else {
            print("nope")
        }
    }
}


struct So_k_Station_Previews: PreviewProvider {
    
    @State static var isShowingSheet: Bool = false
    @State static var StationID: String = "Inget"
    @State static var StationNamn: String = "Inget"
    
    static var previews: some View {
        So_k_Station(ShowingSheet: $isShowingSheet, StationID: $StationID, StationNamn: $StationNamn)
    }
}

