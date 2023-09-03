//
//  Get time.swift
//  Auto Resa
//
//  Created by Oliver Drevet on 2022-03-01.
//

import SwiftUI

struct Get_time: View {
    
    @State var Tid: String = "2022-03-01T13:38:15"
    @State var PredictedTid: String = "2022-03-01T13:38:15"
    
    @State var NyTid: String = "Inget"
    @State var NyPredictedTid: String = "Inget"
    
    var body: some View {
        Group {
            if (NyTid == NyPredictedTid && NyTid != "Inget"){
                Text(NyTid)
            } else{
                HStack {
                    Text(NyPredictedTid)
                    Text(NyTid).strikethrough().opacity(0.5)
                }
            }
        }.onAppear{
            NyTid = getFormattedTime(Hela: Tid)
            NyPredictedTid = getFormattedTime(Hela: PredictedTid)
        }
    }
    
    func getFormattedTime(Hela: String) -> String{
        
        
        var separerad = Hela.map{ String($0) }
        
        if (separerad.count == 19) {
            separerad.removeSubrange(0..<11)
            separerad.removeSubrange(5..<8)
            let nya = separerad.joined(separator: "")
            return nya
        }else {
            return "Inget"
        }
        
    }
    
}

struct Get_time_Previews: PreviewProvider {
    static var previews: some View {
        Get_time()
    }
}
