//
//  TimeFormate.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-03-18.
//

import SwiftUI

struct TimeFormate: View {
    
    @State var TimeOrigin: String = "17:58:00"
    @State var TimeDestination: String = "18:00:00"
    
    @State var RTimeOrigin: String? = "17:51:00"
    @State var RTimeDestination: String? = "18:00:00"
    
    var body: some View {
        
        HStack(spacing: 5){
            
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
            Image(systemName: "chevron.forward")
                .imageScale(.small)
            
            if (RTimeDestination != nil && TimeDestination != RTimeDestination) {
                

            
                HStack{
                    Text(getFormattedTime(Hela: RTimeDestination ?? ""))
                        .font(.system(size: 14))
                    Text(getFormattedTime(Hela: TimeDestination))
                        .font(.system(size: 14))
                        .strikethrough().opacity(0.5)
                }

            } else {
                Text(getFormattedTime(Hela: TimeDestination))
                    .font(.system(size: 14))
            }
            
//            Text(getFormattedTime(Hela: TimeDestination))
//                .font(.system(size: 14))
            
        }.padding(.trailing)
        
//        Text(getFormattedTime(Hela: Time))
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

struct TimeFormate_Previews: PreviewProvider {
    static var previews: some View {
        TimeFormate()
    }
}
