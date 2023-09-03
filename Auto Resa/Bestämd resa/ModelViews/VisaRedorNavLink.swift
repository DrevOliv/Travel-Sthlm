//
//  VisaRedorNavLink.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-05-24.
//

import SwiftUI
import MapKit

struct VisaResorNavLink: View {
    
    @State var Latitude: String
    @State var Longitude: String
    
    @State var array: legList?
    
    @State var KlarAttVisa = false
    
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    @State var AnnotationArray: [StationLocationsMap] = []
    
    var body: some View {
        ScrollView{
        Group{
            
            if (KlarAttVisa) {
            ScrollView{
                VStack{
                    
                    ForEach(array?.Leg ?? []){ index1 in
                        
                        if (index1.type ?? "" == "JNY") {
                            
                            DisclosureGroup("Stationer: \(index1.name?.capitalized ?? "Fel")") {
                            VStack{
                                ForEach(index1.Stops?.Stop ?? []) { index2 in
                                    HStack{
                                        Text(index2.name ?? "")
                                        
                                        //.font(index3.name ?? "" == index2.Stops?.Stop?.first?.name ?? "" ? .title : .footnote)
                                        
                                        if (index2.rtDepTime != nil){
                                            TimeFormateONE(TimeOrigin: index2.depTime ?? "", RTimeOrigin: index2.rtDepTime ?? "")
                                        } else if (index2.rtArrTime != nil){
                                            TimeFormateONE(TimeOrigin: index2.arrTime ?? "", RTimeOrigin: index2.rtArrTime ?? "")
                                        }
                                        
                                    }
                                }
                            }
                        }
                        } else {
                            EmptyView()
                        }
                        
                        
                        
                        
                        
                        
                        
//                        VStack{
//                            ForEach(index1.Stops?.Stop ?? []) { index2 in
//                                HStack{
//                                    TextFormate(text: index2.name ?? "")
//
//                                    //                                                                .font(index3.name ?? "" == index2.Stops?.Stop?.first?.name ?? "" ? .title : .footnote)
//                                    if (index2.depTime ?? "" != ""){
//                                        TimeFormateONE(TimeOrigin: index2.depTime ?? "", RTimeOrigin: index2.rtDepTime ?? "")
//                                    } else {
//                                        TimeFormateONE(TimeOrigin: index2.arrTime ?? "", RTimeOrigin: index2.rtArrTime ?? "")
//                                    }
//                                }
//                            }
//                        }
                    }
                    
                    
                }
            }
                
                VStack{

                    NavigationLink(destination:{

                        Map(coordinateRegion: $region, annotationItems: AnnotationArray) { place in
                            MapAnnotation(coordinate: place.coordinate) {
                                
                                Image(systemName: "face.smiling.fill")
                                
                            }
                        }
                        .ignoresSafeArea()

                    }, label: {
                        Image(systemName: "map.fill")

                    })

                }
            
            }
            else {
                EmptyView()
                
            }
        }
        .onAppear {
            
            guard let DoubleLat = Double(Latitude), let DoubleLon = Double(Longitude) else { return print("Fel")}
            
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: DoubleLat, longitude: DoubleLon), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            MapaUtStationerna(array: array?.Leg ?? [])
            
            KlarAttVisa = true
            
        }
        }
    }
    
    
    func MapaUtStationerna(array: Array<leg>)  {
//        -> Array<StationLocationsMap>
        
        for stops in array {
            
//            print(stops)
            
            for stop in (stops.Stops?.Stop ?? []) {
                
//                print(stop)
                return
                
            }
            
        }
            
    }
    
    
    
}




extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
