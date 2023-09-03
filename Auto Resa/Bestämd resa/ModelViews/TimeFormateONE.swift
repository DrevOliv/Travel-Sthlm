//
//  TimeFormateONE.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-04-07.
//

import SwiftUI

struct TimeFormateONE: View {
    
    @State var TimeOrigin: String = "17:58:00"
    @State var RTimeOrigin: String? = "17:51:00"
    
    var body: some View {
        if (RTimeOrigin != nil && RTimeOrigin != TimeOrigin) {
            

                HStack{
                    Text(getFormattedTime(Hela: RTimeOrigin ?? ""))
                        .font(.system(size: 14))
                    Text(getFormattedTime(Hela: TimeOrigin))
                        .font(.system(size: 14))
                        .strikethrough().opacity(0.5)
                }

            } else {
                Text(getFormattedTime(Hela: TimeOrigin))
                    .font(.system(size: 14))
            
        }
    }
    
    func getFormattedTime(Hela: String) -> String{
        
        
        var separerad = Hela.map{ String($0) }
        
        if (separerad.count == 8) {
            separerad.removeSubrange(5..<8)
            let nya = separerad.joined(separator: "")
            return nya
        }else {
            print("TimeFormate: \(separerad)")
            return "Inget"
        }
        
    }
}


struct TimeFormateONE_Previews: PreviewProvider {
    static var previews: some View {
        TimeFormateONE()
    }
}
