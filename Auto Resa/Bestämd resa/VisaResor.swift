//
//  VisaResor.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-03-11.
//

import SwiftUI
import MapKit


struct VisaResor: View {
    
    @State var öppnaInställningarm = false
    
    let Brovaktarvägen = "7085"
    let Fruängen = "9260"
    let id = "9120"
    
    
    @State var api = Api()
    @ObservedObject var locationManager = LocationManager.shered
    
    @EnvironmentObject var vmCoreData: CoreDataManager
    
    @Environment(\.scenePhase) var scenePhase
    
    @State var EttFel = false
    @State var Loading = false
    @State var Cancel = false
    @State var IngaStationer = true
    @State var HittaStation = false
    
    @State var Latitude = "Inget"
    @State var Longitude = "Inget"
    
    @State var stationer: Stationer = Stationer(stopLocationOrCoordLocation: [])
    @State var resor: Resor = Resor(Trip: [])
    
    
    
    
    @State var prepering = true
    @State var Stations = []
    
    @State var NotificationFel = false
    @State var NotificationUnderTime = false
    @State var HarSattPåminnelse = false
    @State var TilllåtaNotification = false
    @State var SwipeButtonTint: Color = Color.green
    
    @AppStorage("AutoPåminnelseAvgång") var intervalNoti = 15
    @AppStorage("SearchRadius") var SearchRadius = 1000
    
    @State var ShowSettings = false
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 0){
                
                
                //        NavigationView{
                
                ZStack{
                    
                    
                    VStack(spacing: 0){
                        Group{
                            if (vmCoreData.savedStationer.isEmpty){
                                Spacer()
                                VStack {
                                    Text("Inga stationer finns")
                                    NavigationLink(destination: Visa_Redigera()){
                                        Text("Skapa Resa")
                                            .padding()
                                            .padding(.horizontal)
                                            .foregroundColor(.white)
                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                                    }
                                    
                                }
                                Spacer()
                            } else if (Loading) {
                                Spacer()
                                ProgressView()
                                Spacer()
                                
                            } else if (Cancel){
                                
                                Spacer()
                                Text("Ett fel inträffade!")
                                    .font(.title2)
                                Spacer()
                                
                            } else if (IngaStationer){
                                
                                Spacer()
                                
                                VStack(spacing: 20){
                                    Text("Inga av stationerna")
                                        .font(.title2)
                                    Text("hittades i närheten")
                                        .font(.title2)
                                    Button {
                                        if (vmCoreData.savedStationer.isEmpty != true) {
                                            setLatLon()
                                        }
                                    } label: {
                                        Image(systemName: "arrow.clockwise")
                                            .foregroundColor(Color.blue)
                                            .font(.system(size: 30))
                                    }

                                }
                                
                                Spacer()
                                
//                                Spacer()
//                                List{
//                                    Spacer().listRowBackground(Color.green.opacity(0)).listRowSeparator(.hidden)
//                                    Spacer().listRowBackground(Color.green.opacity(0)).listRowSeparator(.hidden)
//                                    Spacer().listRowBackground(Color.green.opacity(0)).listRowSeparator(.hidden)
//                                    Section{
//                                        Text("Inga av stationerna hittades i närheten")
//                                    }.listRowBackground(Color.green.opacity(0))
//                                        .listRowSeparator(.hidden)
//
//
//                                }
//                                .refreshable{
//                                    if (vmCoreData.savedStationer.isEmpty != true) {
//                                        setLatLon()
//                                    }
//                                }
//                                Spacer()
                            }
                            else {
                                VStack{
                                    List(resor.Trip ?? []){ index in
                                        
                                        ZStack{
                                            
                                            //                                    NavigationLink(destination:{
                                            //                                        VisaResorNavLink(Latitude: Latitude, Longitude: Longitude, array: index.LegList ?? nil)
                                            //                                    }, label: {
                                            //                                        EmptyView()
                                            //                                    })
                                            
                                            VStack{
                                                
                                                ResaListStyle(index: index)
                                                
                                            }
                                            
                                            
                                        }
                                        
                                        .SwipeNotification(list: index, intervalNoti: intervalNoti, NotificationFel: $NotificationFel, NotificationUnderTime: $NotificationUnderTime, HarSattPåminnelse: $HarSattPåminnelse, TilllåtaNotification: $TilllåtaNotification)
                                        
                                        
                                    }
                                    
                                    .refreshable{
                                        if (vmCoreData.savedStationer.isEmpty != true) {
                                            setLatLon()
                                        }
                                    }
                                    .listStyle(.inset)
                                    
                                }
                            }
                        }     
                    }
                    .zIndex(0)
                    
                    .navigationTitle("Resor")
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing){
                            HStack{
                                NavigationLink(destination: Visa_Redigera()){
                                    VStack{
                                        Image(systemName: "list.bullet")
                                        Text("Station Lista")
                                    }
                                }
                                
                                //                    Button("Button title") {
                                //                        NotificationFel = true
                                //                    }
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading){
                            HStack{
                                Button {
                                    ShowSettings = true
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                }

                            }
                        }
                    }
                    
                    .AlertCustom(Bindning: $NotificationFel, Title: "Ett fel inträffa", Message: "Kunde inte sätta påminnelse", ButtonOne: "Fortsätt" )
                    
                    
                    //            .modifier(AlertCustom(Bindning: $TilllåtaNotification, Title: "Kunde inte sätta påmminelse", Message: "Måste sätta på notificationer in inställningar för att kunna använda denna", ButtonOne: "Fortsätt" ))
                    
                    .AlertCustom(Bindning: $NotificationUnderTime, Title: "Fel", Message: "Kunde inte sätta påminnelse, tiden mellan är kortare än \(intervalNoti) min", ButtonOne: "Fortsätt" )
                    
                    .alert("Kunde inte sätta påmminelse", isPresented: $TilllåtaNotification) {
                        Button("fortsätt") {
                            
                        }
                        Link("Öppna Inställningar", destination: URL(string: "app-settings:root=General&path=About")!)
                    } message: {
                        Text("Måste tillåta påminnelse, för att sätta påminnelse")
                    }
                    
                    .alert("Ett fel inträffa", isPresented: $EttFel) {
                        Button("Prova Igen") {
                            setLatLon()
                        }
                        Button("Avbryt") {
                            
                        }
                    }
                    
                    
                    if HarSattPåminnelse {
                        FloatingNotice(showingNotice: $HarSattPåminnelse)
                            .zIndex(1)
                    }
                    
                    
                }
                Tabview()
                
            }
            .sheet(isPresented: $ShowSettings) {
                SettingClass.SettingsAutoResa()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
//                }
        .onAppear{
            
            if (vmCoreData.savedStationer.isEmpty != true && !Loading) {
                setLatLon()
            }
            
        }
        .onChange(of: scenePhase) { Phase in
            
            switch Phase {
            case .active:
                if (vmCoreData.savedStationer.isEmpty != true && !Loading) {
                    setLatLon()
                }
                
            case .background:
                return
            case .inactive:
                return
            @unknown default:
                print("Unknown State")
            }
        }
        
        
        //        .navigationViewStyle(StackNavigationViewStyle())
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func setLatLon() {
        if(locationManager.userlocation != nil){
            Loading = true
            
            
            Latitude = String(locationManager.userlocation!.coordinate.latitude)
            Longitude = String(locationManager.userlocation!.coordinate.longitude)
            
            
            print(Latitude, Longitude)
            
            print("1")
            
            SökStation()
            
        } else {
            return
            //            OpenSettings()
        }
    }
    
    func SökStation() {
        
        if (Latitude != "Inget" && Longitude != "Inget"){
            
            api.getStation(latitude: Latitude, longitud: Longitude, radius: SearchRadius) { stationer in
                self.stationer = stationer
                print("2")
                CheckStations()
                
                if (api.getStation_fel == true) {
                    EttFel = true
                }
            }
        } else {
            EttFel = true
            HapticManager.instance.notification(type: .error)
        }
    }
    
    func CheckStations() {
        if (vmCoreData.savedStationer.isEmpty) {
            Loading = false
        } else {
            HittaStation = false
            
        outerLoop: for i in stationer.stopLocationOrCoordLocation {
            
            for j in vmCoreData.savedStationer {
                
                if (get_stationId(Hela: i.StopLocation?.mainMastExtId ?? "Inget") == j.avgangid){
                    HittaStation = true
                    IngaStationer = false
                    
                    SökAvgångar(Origin: j.avgangid ?? "Inget",Destination: j.destinationid ?? "Inget")
                    print("3")
                    break outerLoop
                }
            }
        }
            if (HittaStation == false){
                IngaStationer = true
                Loading = false
            }
        }
        
    }
    
    func SökAvgångar(Origin: String, Destination: String) {
        if (Origin != "Inget" && Destination != "Inget"){
            api.getResor(origin: Origin, destination: Destination) { resor in
                self.resor = resor
                
                print("Sökte Svgångar")
                Loading = false
                HapticManager.instance.notification(type: .success)
            }
        } else {
            EttFel = true
            HapticManager.instance.notification(type: .error)
        }
    }
    
    func get_stationId(Hela: String) -> String{
        
        
        if (Hela != "Inget" && Hela.count != 0) {
            var separerad = Hela.map{ String($0) }
            
            if (separerad.count > 5) {
                separerad.removeSubrange(0..<5)
                let nya = separerad.joined(separator: "")
                
                
                //                Provisional
                if nya == "1080" {
                    return "9001"
                } else {
                    return nya
                }
                
            }
            
        } else {
            EttFel = true
            HapticManager.instance.notification(type: .error)
            return "Inget"
            
        }
        return "Inget"
    }
    
    
    
    
    
    
    
}

struct VisaResor_Previews: PreviewProvider {
    static var previews: some View {
        VisaResor()
    }
}




