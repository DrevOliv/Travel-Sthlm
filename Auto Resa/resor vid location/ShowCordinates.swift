//
//  ShowCordinates.swift
//  Auto Resa
//
//  Created by Oliver Drevet on 2022-02-23.
//

import SwiftUI

struct ShowCordinates: View {
    
    @State var api = Api()
    @ObservedObject var locationManager = LocationManager.shered
    @State var stationer: Stationer = Stationer(stopLocationOrCoordLocation: [])
    
    @AppStorage("SearchRadius") var SearchRadius = 1000
    
//    @State var Latitude = "59.2864677"
//    @State var Longitude = "17.964876"
    
    @State var Latitude = "Inget"
    @State var Longitude = "Inget"
    
    @State var stationHittades = "Inget"
    @State var test = "Inget"
    @State var StationId = "0"
    
    @State var Loading = false
    @State var EttFel = false
    @State var Cancel = false
    
    @State var AntalSöknignar = 0
    
    let height = UIScreen.main.bounds.size.height
    
    var body: some View {
        
//        NavigationView{
            VStack{
                Group{
                    if (Loading) {
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else if (Cancel){
                        Spacer()
                        Text("Ett Fel Inträffade!")
                            .font(.title2)
                        Spacer()
                    } else {
                        List(stationer.stopLocationOrCoordLocation) { index in
                            ZStack{

                                StationNamesViewModel(StationData: index)
                                
                                
                                NavigationLink("Inget") {
                                    
                                    ShowStations(StationNamn: index.StopLocation?.name ?? "fel", ExtenId: index.StopLocation?.mainMastExtId ?? "Inget")
                                    
                                }.opacity(0)
                            }.listRowBackground(Color.gray.opacity(0))

                            
                            .padding(-5)
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.inset)
                        .refreshable {
                            setLatLon()
                        }
                    }
                
                    
                
            }
            .navigationTitle("Hittade stationer")
            .alert("Ett fel inträffade", isPresented: $EttFel) {
                HStack{
                    Button("Prova igen") {
                        setLatLon()
                    }
                    Button("Avbryt") {Cancel = true}
                }
            }
            .navigationBarItems(trailing: NavigationLink(destination: {Text("Made By Oliver Drevet")}, label: {Text("Hidden").opacity(0)}))
//            .navigationBarItems(leading: NavigationLink(destination: SettingClass.SettingsPosition(), label: {Image(systemName: "gearshape.fill")}))
                

            }
//        }
        .onAppear{
            if ( locationManager.userlocation != nil) {
            setLatLon()
            }
//            SökStation()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    func setLatLon() {
        Loading = true
        
        Latitude = String(locationManager.userlocation!.coordinate.latitude)
        Longitude = String(locationManager.userlocation!.coordinate.longitude)
        
        print(Latitude, Longitude)
        
        SökStation()
    }
    
    func SökStation() {
        
        if (Latitude != "Inget" || Longitude != "Inget" && AntalSöknignar < 2){
            api.getStation(latitude: Latitude, longitud: Longitude, radius: SearchRadius) { stationer in
                self.stationer = stationer
                HapticManager.instance.notification(type: .success)
                Loading = false
                
                
                if (api.getStation_fel == true) {
                    HapticManager.instance.notification(type: .error)
                    EttFel = true
                }
                
            }
        } else {
            HapticManager.instance.notification(type: .error)
            EttFel = true
        }
        
        
    }
    
}
//
//struct ShowCordinates_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowCordinates()
//    }
//}



//    func checkStation(TargetStation: String) {
//        print(stationer.stopLocationOrCoordLocation)
//        print("Steg 2")
//        if (stationer.stopLocationOrCoordLocation.isEmpty == false ){
//            for station in stationer.stopLocationOrCoordLocation {
//                if (station.StopLocation?.name == TargetStation) {
//                    stationHittades = station.StopLocation?.name ?? "Inget"
//                    StationId = get_stationId(Hela: "\(station.StopLocation?.mainMastExtId ?? "0")")
//                }
//            }
//
//        }
//    }
