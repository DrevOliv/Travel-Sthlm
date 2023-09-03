//
//  Structs.swift
//  Auto Resa
//
//  Created by Oliver Drevet on 2022-02-24.
//

import Foundation
import CoreLocation

// MARK: - Stationer

struct Stationer: Codable {
    let stopLocationOrCoordLocation: [StopLocationOrCoordLocation]
}


struct StopLocationOrCoordLocation: Codable, Identifiable {
    let id = UUID()
    let StopLocation: stopLocation?
}


struct stopLocation: Codable {
    let mainMastExtId: String?
    let name: String?
    let lon: Double?
    let lat: Double?
    let weight: Int?
    let dist: Int?
    let products: Int?
}

// MARK: - Realtidsinfo

struct Avgångar: Decodable{

    let ResponseData: responseData?
}

struct responseData: Decodable {
    let Metros: [InfoMation]?
    let Buses: [InfoMation]?
    let Trains: [InfoMation]?
    let Trams: [InfoMation]?
    let Ships: [InfoMation]?
    
}

struct InfoMation: Decodable , Hashable,Identifiable{
    let GroupOfLine: String?
    let LineNumber: String?
    let Destination: String?
    let StopAreaName: String?
    let TimeTabledDateTime: String?
    let ExpectedDateTime: String?
    let DisplayTime: String?
    let TransportMode: String?
    let Deviations: [daviations]?
    let id = UUID()
    
}

struct daviations: Decodable, Hashable {
    let Text: String?
}


//MARK: - Resplanerare


struct Resor: Codable{
    let Trip: [trip]?
    
}

struct trip: Codable, Identifiable {
    let id = UUID()
    let LegList: legList?

}

struct legList: Codable {
    let Leg: [leg]?
}

struct leg: Codable, Identifiable {
    let id = UUID()
    let Product: product?
    let Destination: stationStruct?
    let Origin: stationStruct?
    let Messages: messages?
    let Stops: stOps_Stop?
    let JourneyDetailRef: journeydetailref?
    let type: String?
    let name: String?
    let category: String?

}

struct journeydetailref: Codable {
    let ref: String?
}

struct stationStruct: Codable {
    let name: String?
    let date: String?
    let time: String?
    let rtDate: String?
    let rtTime: String?
    let line: String?
    let lon: Float?
    let lat: Float?
    
}

struct product: Codable {
    let name: String?
    let line: String?
    let catOutL: String?
    let catOut: String?
}

struct messages: Codable{
    let Message: [message_cell]?
}

struct message_cell: Codable{
    let text: String?
}

struct stOps_Stop: Codable {
    let Stop: [stop_Stop]?
}

struct stop_Stop: Codable, Identifiable {
    let id = UUID()
    let name: String?
    let lon: Double?
    let lat: Double?
    let depTime: String?
    let rtDepTime: String?
    let arrTime: String?
    let rtArrTime: String?

}

//MARK: - Sök Stationer

struct Stationer_Sök: Codable {
    let ResponseData: [responsedatam]
    
}

struct responsedatam: Codable, Identifiable{
    let Name: String?
    let SiteId: String?
    let `Type`: String?
    let X, Y: String?
    let id = UUID()
}

//MARK: - Map pinout

struct Station: Identifiable {
    
    let id = UUID()
    let coordinates: CLLocationCoordinate2D
    let name: String
    let time: String
    
}






//MARK: - MAPSTRCUT

struct StationLocationsMap: Identifiable {
    let id = UUID()
    let name: String
    let Id: String
    let weight: Int
    let products: Int
    let show: Bool
    let coordinate: CLLocationCoordinate2D
    
}
