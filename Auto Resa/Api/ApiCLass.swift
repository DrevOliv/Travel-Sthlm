//
//  ApiCLass.swift
//  Auto Resa
//
//  Created by Oliver Drevet on 2022-02-24.
//

import Foundation

class Api {
    
    var getStation_fel = false
    var getAvgångar_fel = false
    var getStation_Sök_fel = false
    var getResov_fel = false
    var getStation_detail = false
    
    func getStation(latitude: String, longitud: String, radius: Int, completion: @escaping (Stationer) -> ()) {
        
        guard let url = URL(string: "https://api.sl.se/api2/NearbystopsV2.json?key=00fbd028ea5245d7bb098684485a0294&originCoordLat=\(latitude)&originCoordLong=\(longitud)&maxNo=15&r=\(radius)") else { return }
        
        print(url)
        
//        guard let url = URL(string: "https://api.sl.se/api2/NearbystopsV2.json?key=710a741649fa4be597e920270bbd83d5&originCoordLat=59.266473&originCoordLong=17.961745") else { return }
        //710a741649fa4be597e920270bbd83d5
        
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            
            do {
                let stationer = try JSONDecoder().decode(Stationer.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(stationer)
                    
                    print("Sökte Stationer")
                }
            } catch {
                print("Fel")
                self.getStation_fel = true
                completion(Stationer(stopLocationOrCoordLocation: []))
                
            }
            
            
        }.resume()
    }
    
    func getAvgångar(SiteId: String, TimeWindow: String, completion: @escaping(Avgångar) -> ()) {
        
        guard let url = URL(string: "https://api.sl.se/api2/realtimedeparturesv4.json?key=d8a0181ae161407d916b60459f3e1672&siteid=\(SiteId)&timewindow=\(TimeWindow)") else {return}
        
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(Avgångar.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(result)
                        
                    }
                } catch {
                    print("fel")
                    self.getAvgångar_fel = true
                }
            }
        }
        .resume()
    }
    
    
    func getStationer_Sök(station: String, completion: @escaping(Stationer_Sök) -> ()) {
        
        
        let utanSpecial = station.replacingOccurrences(of: "ä", with: "%C3%A4").replacingOccurrences(of: "å", with: "%C3%A5").replacingOccurrences(of: "ö", with: "%C3%A5").replacingOccurrences(of: " ", with: "%20")
            
//            .replacingOccurrences(of: "-", with: "")
       
    // https://api.sl.se/api2/typeahead.json?key=1d920aa0229c4e79bc235c288e8ae11c&searchstring=\(utanSpecial)&stationsonly=false
        
        
        print("1 \(station)")
        guard let url = URL(string: "https://api.sl.se/api2/typeahead.json?key=a27620a81e2b4becb612d60d136ae562&searchstring=\(utanSpecial)&stationsonly=true") else {return}
        print("2 \(url)")
    
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                
                do {
                    let station = try JSONDecoder().decode(Stationer_Sök.self, from: data)
                
                    DispatchQueue.main.async {
                        completion(station)
                    }
                } catch {
                    print("fel")
                    self.getStation_Sök_fel = true

                }
                
            }
        }
        .resume()
    }
    
    
    func getResor(origin: String, destination: String, completion: @escaping(Resor) -> ()) {
        guard let url = URL(string: "https://api.sl.se/api2/TravelPlannerV3_1/trip.json?key=f16160348c734ffb91ae594a1e8f6a46&originId=\(origin)&destId=\(destination)&searchForArrival=0&realtime=true&Passlist=1") else {return}
    
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(Resor.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(result)
                        
                    }
                } catch {
                    
                    print("fel")
                    self.getResov_fel = true
                    print(error)
                }
                

            }
        }
        .resume()
    }
    
}
