//
//  ListVisaResorModel.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-03-16.
//

import SwiftUI

struct ListVisaResorModel: View {
    
    
    @State var type: String = "JNY"
    @State var name: String = "tunnelbanans gröna linje 18"
    @State var catOut: String = "TRAM          "
    
    var body: some View {
        Group{
            if (type.contains("JNY")){
                
                VStack{
                    
                    Text(FormatLinenameInverted(name))
                        .font(.system(size: 12))
                    Image(systemName: getSymbol(catOut))
                        .font(.system(size: 20))
                        .foregroundColor(getColor(FormatLinename(name)))
                }
                .frame(width: 35, height: 50)
                //                .padding(5)
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.white).shadow(color: Color.gray, radius: 1, x: 0, y: 0).opacity(0.5))
                
            } else {
                EmptyView()
            }
        }
        
    }
    
    let FormatLinename = { (FullString: String) -> String in
        
        let line = CharacterSet.init(charactersIn: "0123456789")
        
        let cleanChars  = FullString.components(separatedBy: line).joined(separator: "")
        
        return cleanChars
        
    }
    
    let FormatLinenameInverted = { (FullString: String) -> String in
        
        let line = CharacterSet.init(charactersIn: "0123456789").inverted
        
        let cleanChars  = FullString.components(separatedBy: line).joined(separator: "")
        
        return cleanChars
        
    }
    
    
    
    let getColor = { (string: String) -> Color in
        
        switch string {
        case _ where string.contains("tunnelbanans röda linje"): return Color.red
        case _ where string.contains("tunnelbanans gröna linje"): return Color.green
        case _ where string.contains("tunnelbanans blå linje"): return Color.blue
        case _ where string.contains("buss"): return Color.red
        case _ where string.contains("Buss"): return Color.red
        case _ where string.contains("Buss E"): return Color.red
        case _ where string.contains("buss E"): return Color.red
        case _ where string.contains("blåbuss"): return Color.blue
        case _ where string.contains("Blåbuss"): return Color.blue
        case _ where string.contains("blåbuss E"): return Color.blue
        case _ where string.contains("Blåbuss E"): return Color.blue
        case _ where string.contains("Ersättningsbuss"): return Color.red
        case _ where string.contains("fel"): return Color.red
        case _ where string.contains("Närtrafiken"): return Color.red
        case _ where string.contains("Pendeltåg"): return Color(red: 225/255, green: 89/255, blue: 149/255)
        case _ where string.contains("Spårväg City"): return Color(red: 124/255, green: 128/255, blue: 129/255)
        case _ where string.contains("Djurgårdslinjen"): return Color(red: 124/255, green: 128/255, blue: 129/255)
        case _ where string.contains("Nockebybanan"): return Color(red: 99/255, green: 130/255, blue: 154/255)
        case _ where string.contains("Tvärbanan"): return Color(red: 232/255, green: 129/255, blue: 59/255)
        case _ where string.contains("Waxholmsbolagets"): return Color.blue
        case _ where string.contains("Emelie"): return Color.blue
        case _ where string.contains("Lisen/Lotten"): return Color.blue
        case _ where string.contains("Fjäderholmslinjen"): return Color.blue
        case _ where string.contains("Pendelbåt"): return Color.blue
        case _ where string.contains("Cinderellabåt"): return Color.blue
        case _ where string.contains("Tärnan"): return Color.blue
        case _ where string.contains("Saltsjöbanan"): return Color.red
            
        default: return Color.black
        }
    }
    
    
    let getSymbol = { (string: String) -> String in
        
        switch string {
        case _ where string.contains("METRO"): return "tram.fill.tunnel"
        case _ where string.contains("BUS"): return "bus.fill"
        case _ where string.contains("TRAIN"): return "tram.fill"
        case _ where string.contains("TRAM"): return "tram.fill"
        case _ where string.contains("SHIP"): return "ferry.fill"
        case _ where string.contains("FERRY"): return "ferry.fill"
            
        default: return "square"
        }
        
        
    }
    
}

struct ListVisaResorModel_Previews: PreviewProvider {
    static var previews: some View {
        ListVisaResorModel()
    }
}
