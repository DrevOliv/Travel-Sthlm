//
//  VisaResorModelView.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-03-12.
//

import SwiftUI

struct VisaResorModelView: View {
    
  
    @State var type: String = "JNY"
    @State var name: String = "tunnelbanans gröna linje 999"
    
    
    var body: some View {
        VStack{
            ZStack{
                Text(FormatLineNumb(FullString: name))
                    .padding(.bottom, 7)
                    .font(.system(size: getSize()))
                Image(systemName: getType())
                    .font(.system(size: 30))
                    .foregroundColor(getColor())
            }
        }
    }
    
    func FormatLinename(FullString: String) -> String {

        let line = CharacterSet.init(charactersIn: "0123456789")
        
        let cleanChars  = FullString.components(separatedBy: line).joined(separator: "")
        
        return cleanChars
    }
    
    func FormatLineNumb(FullString: String) -> String {
        
        let lineNumber = CharacterSet.init(charactersIn: "0123456789").inverted
        
        let formated = FullString.components(separatedBy: lineNumber).joined(separator: "")
        
        return formated
    }
    
    func getSize() -> CGFloat{
        let Numb = FormatLineNumb(FullString: name)
        
        if (Numb.count == 1){
            return CGFloat(14)
        } else if (Numb.count == 2){
            return CGFloat(13)
        } else {
            return CGFloat(10)
        }
    }
    
    func getType() -> String {
        if (type.contains("JNY")){
            return getSymbol()
        } else if (type.contains("WALK")) {
            return "arrow.forward"
        }
        return "questionmark.square.fill"
    }
    
    
    func getColor() -> Color {
        if (type.contains("WALK")){
            return Color.black
        }
        else {
            let listaFärg = [
                "tunnelbanans röda linje ": Color.red,
                "tunnelbanans gröna linje ": Color.green,
                "tunnelbanans blå linje ": Color.blue,
                "buss ": Color.red,
                "Buss ": Color.red,
                "blåbuss ": Color.blue,
                "Ersättningsbuss ": Color.red,
                "Pendeltåg ": Color(red: 225/255, green: 89/255, blue: 149/255),
                "Spårväg City ": Color(red: 124/255, green: 128/255, blue: 129/255),
                "Djurgårdslinjen ": Color(red: 124/255, green: 128/255, blue: 129/255),
                "Nockebybanan ": Color(red: 99/255, green: 130/255, blue: 154/255),
                "Tvärbanan ": Color(red: 232/255, green: 129/255, blue: 59/255)
                
            ]
            
            return listaFärg[FormatLinename(FullString: name)] ?? Color.black
        }
    }
    
    func getSymbol() -> String{
        
        let listaSymbol = [
            "tunnelbanans röda linje ": "tram.fill",
            "tunnelbanans gröna linje ": "tram.fill",
            "tunnelbanans blå linje ": "tram.fill",
            "buss ": "bus.fill",
            "Buss ": "bus.fill",
            "blåbuss ": "bus.fill",
            "Ersättningsbuss ": "bus.fill",
            "Pendeltåg ": "tram.fill",
            "Spårväg City ": "tram.fill",
            "Djurgårdslinjen ": "tram.fill",
            "Nockebybanan ": "tram.fill",
            "Tvärbanan ": "tram.fill",
        ]
        
         return listaSymbol[FormatLinename(FullString: name)] ?? "square"
        
    }
    
}

struct VisaResorModelView_Previews: PreviewProvider {
    static var previews: some View {
        VisaResorModelView()
    }
}
