//
//  StationNamesViewModel.swift
//  Auto Resa
//
//  Created by Oliver Drevet on 2022-03-03.
//

import SwiftUI
import MapKit

struct StationNamesViewModel: View {
    
    
    @State var StationData: StopLocationOrCoordLocation = StopLocationOrCoordLocation(StopLocation: stopLocation(mainMastExtId: "400111011", name: "Slussen", lon: 17.963045, lat: 59.262456, weight: 15496, dist: 227, products: 74))
    
    
    let columns = [
        GridItem(.flexible(minimum: 0, maximum: 10), spacing: 0, alignment: .center),
        GridItem(.flexible(minimum: 0, maximum: 10), spacing: 0, alignment: .center),
        
    ]
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text(StationData.StopLocation?.name ?? "Fel")
                HStack{
                    Text("Distans: \(StationData.StopLocation?.dist ?? 0)m")
                    
                    //                    VStack{
                    //                    LazyVGrid(columns: columns, spacing: 0 ) {
                    //
                    //                        ForEach(getTransports(StationData.StopLocation?.products ?? 0)) { data in
                    ////                            Image(systemName: data.icon)
                    ////                                .foregroundColor(data.color)
                    //                            Rectangle()
                    //
                    //                        }
                    //
                    //                    }}
                    
                }
                HStack{
                    ForEach(getTransports(StationData.StopLocation?.products ?? 0)) { data in
                        
                        Image(systemName: data.icon)
                            .foregroundColor(data.color)
                        
                    }
                }
            }
            .padding()
            
            
            Spacer()
            
            Image(systemName: "chevron.forward")
                .imageScale(.large)
                .padding()
                .opacity(0.5)
        }
        .background(RoundedRectangle(cornerRadius: 5).fill(Color.white).shadow(color: Color.gray, radius: 1, x: 0, y: 0).opacity(0.5))
    }
    
    var getTransports = { (product: Int) -> ([IconColor]) in
        
        var ProductDic: [IconColor] = []
        
        
        
        var rest: Int = product
        
        if product != 0 {
            
            for i in [ 128, 64, 32, 16, 8, 4, 2, 1 ] {
                
                if rest - i >= 0 {
                                        
                    rest = (rest - i)
                    
                    switch i {
                    case 128: print("")
                    case 64: ProductDic.append(IconColor(icon: "ferry.fill", color: Color.blue))
                        
                    case 32: print("")
                    case 16: print("")
                    case 8: ProductDic.append(IconColor(icon: "bus.fill", color: Color.red))
                        
                    case 4: ProductDic.append(IconColor(icon: "tram", color: Color(red: 99/255, green: 130/255, blue: 154/255)))
                        
                    case 2: ProductDic.append(IconColor(icon: "tram.fill.tunnel", color: Color.red))
                        
                    case 1: ProductDic.append(IconColor(icon: "tram.fill", color: Color(red: 225/255, green: 89/255, blue: 149/255)))
                        
                    default:
                        print("")
                    }
                    
                }
            }
        }
        
        return ProductDic
        
    }
    
    struct IconColor: Identifiable {
        let id = UUID()
        let icon: String
        let color: Color
        
    }
    
    
}

struct StationNamesViewModel_Previews: PreviewProvider {
    static var previews: some View {
        StationNamesViewModel()
    }
}
