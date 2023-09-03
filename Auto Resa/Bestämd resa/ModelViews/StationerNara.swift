//
//  StationerNara.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-08-18.
//

import SwiftUI
import MapKit

struct StationerNara: View {
    
    @ObservedObject var locationManager = LocationManager.shered
    @State var Loading = false
    @State var Latitude = "Inget"
    @State var Longitude = "Inget"
    
    @State var api = Api()
    @State var EttFel = false
    @State var stationer: Stationer = Stationer(stopLocationOrCoordLocation: [])
    
    @State var AnnotationArray: [StationLocationsMap] = []
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    @State var selectedAnnotation: String? = nil
    
    @State var selectedName: String = ""
    @State var selectedId: String = ""
    
    @Binding var SelectedName: String
    @Binding var SelectedId: String
    @Binding var SelectedFromMap: Bool
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $region, annotationItems: AnnotationArray) { place in
                MapAnnotation(coordinate: place.coordinate) {
                    
                    Annotation(name: place.name, Id: place.Id, weight: place.weight, products: place.products, show: place.show, selectedName: $SelectedName, selectedId: $SelectedId, SelectedFromMap: $SelectedFromMap)
                    
                }
            }
            .ignoresSafeArea()
            
            
            VStack{
                Spacer()
            VStack{
                Text("Vald Station:")
                if SelectedName != "Avgång" &&  SelectedName != "Destination" && SelectedName != "Inget" {
                    Text(SelectedName)
                } else {
                    Text(SelectedName).opacity(0)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 5).fill(Color.white).edgesIgnoringSafeArea(.bottom).shadow(color: Color.gray, radius: 10, x: 0, y: 0))
            
            }
            
            
                
            
            if Loading {
                ProgressView()
                    
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .ignoresSafeArea()
            }
            
            if EttFel {
                    
                Rectangle()
                    .fill(Color.white.opacity(0.9))
                    .ignoresSafeArea()
                
                Text("Ett Fel Inträffade")
                    .foregroundColor(Color.black)
                    .font(.title2)
            }
            
            
        }.onAppear{
            
            setLatLon()
            
            guard let DoubleLat = Double(Latitude), let DoubleLon = Double(Longitude) else { return print("Fel")}
            
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: DoubleLat, longitude: DoubleLon), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
        }
        .onChange(of: selectedName) { newValue in
            print(newValue)
        }
        
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
            
            api.getStation(latitude: Latitude, longitud: Longitude, radius: 2000) { stationer in
                
                if (api.getStation_fel == true) {
                    EttFel = true
                } else {
                    self.stationer = stationer
                    GetLatLon()
                }
                
            }
        } else {
            EttFel = true
            HapticManager.instance.notification(type: .error)
        }
    }
    
    
    func GetLatLon() {
        
        for station in stationer.stopLocationOrCoordLocation {
            
            let IdBool = get_stationId(station.StopLocation?.mainMastExtId ?? "Fel")
            
            AnnotationArray.append(
                StationLocationsMap(name: station.StopLocation?.name ?? "Fel", Id: IdBool.id, weight: station.StopLocation?.weight ?? 0, products: station.StopLocation?.products ?? 0, show: IdBool.show, coordinate: CLLocationCoordinate2D(latitude: station.StopLocation?.lat ?? 0, longitude: station.StopLocation?.lon ?? 0))
            )
        }
        Loading = false
            
    }
    
    var get_stationId = { (Hela: String) -> (id: String, show: Bool) in
        
        if (Hela != "Inget" && Hela.count != 0) {
            var separerad = Hela.map{ String($0) }
            
            if (separerad.count > 5) {
                separerad.removeSubrange(0..<5)
                let nya = separerad.joined(separator: "")
                
                
                //                Provisional
                if nya == "1080" {
                    return ("9001", true)
                } else {
                    return (nya, true)
                }
                
            }
            
        } else {
            return ("Fel", false)
        }
        return ("Fel", false)
    }
    
    
}
//
//struct StationerNara_Previews: PreviewProvider {
//    static var previews: some View {
//        StationerNara()
//    }
//}
