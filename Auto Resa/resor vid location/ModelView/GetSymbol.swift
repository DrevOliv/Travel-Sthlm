//
//  GetSymbol.swift
//  Auto Resa
//
//  Created by Oliver Drevet on 2022-03-01.
//

import SwiftUI

struct GetSymbol: View {
    
    @State var LineNumb: String = "9999"
    @State var TransportMode: String = "METRO"
    @State var GoupeOfLines = "Pendeltåg"
    
    @State var Färg: Color = Color.pink
    @State var Symbol: String = "tram.fill"
    
    var body: some View {
        HStack{
            ZStack{
                Text(LineNumb)
                    .padding(.bottom, TextPadding(TransportMode))
                    .font(.system(size: StrolekText(LineNumb)))
                
                
                Image(systemName: HittaSymbol(TransportMode))
                    .font(.system(size: StorlekSymbol(TransportMode)))
                    .foregroundColor(TrasportFärger(GoupeOfLines))
                    .padding(.top, PaddingSymbol(TransportMode))
            }.padding([.top, .bottom], 5)
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.white).shadow(color: Color.gray, radius: 1, x: 0, y: 0).opacity(0.5))
        }
        
    }
    
    
    
    
    let StrolekText = { (linenumb: String) -> CGFloat in
        
        let Count = linenumb.count
        
        switch Count {
            
        case 1: return 13
        case 2: return 13
        case 3: return 11.5
        case 4: return 8
            
        default: return 10
        }
        
    }
    
    let PaddingSymbol = { (string: String) -> CGFloat in
        
        switch string {
        
        case _ where string.contains("METRO"): return 0
        case _ where string.contains("BUS"): return 0
        case _ where string.contains("TRAIN"): return 0
        case _ where string.contains("TRAM"): return 0
        case _ where string.contains("SHIP"): return 10
        case _ where string.contains("FERRY"): return 10
                        
        default: return 60
            
        }
    }
    
    
    let StorlekSymbol = { (string: String) -> CGFloat in
        
        switch string {
        
        case _ where string.contains("METRO"): return 41
        case _ where string.contains("BUS"): return 41
        case _ where string.contains("TRAIN"): return 41
        case _ where string.contains("TRAM"): return 41
        case _ where string.contains("SHIP"): return 34
        case _ where string.contains("FERRY"): return 34
                        
        default: return 60
            
        }
        
    }
    
    
    let TrasportFärger = { (string: String) -> Color in
        
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
    
    let HittaSymbol = { (string: String) -> String in
        
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
    
    let TextPadding = { (string: String) -> CGFloat in
        
        switch string {
        
        case _ where string.contains("METRO"): return 5
        case _ where string.contains("BUS"): return 10
        case _ where string.contains("TRAIN"): return 10
        case _ where string.contains("TRAM"): return 10
        case _ where string.contains("SHIP"): return 50
        case _ where string.contains("FERRY"): return 60
                        
        default: return 60
            
        }
        
    }
    
    
}

struct GetSymbol_Previews: PreviewProvider {
    static var previews: some View {
        GetSymbol()
    }
}
