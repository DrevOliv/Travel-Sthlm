//
//  TransportModeList.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-05-27.
//

import SwiftUI

struct TransportModeList: View {
    
    @State var ArrayList: [InfoMation]
    
    var body: some View {
        
        List(ArrayList){ index in
            ZStack{
                NavigationLink {
                    Text("FUNKAR")
                } label: {
                    EmptyView()
                }

            ListViewStationer(Från_B: index.StopAreaName ?? "fel" ,Till_B: index.Destination ?? "fel", Tid_B: index.TimeTabledDateTime ?? "fel", PredictedTid_B: index.ExpectedDateTime ?? "fel", LineNumb: index.LineNumber ?? "fel", TransportMode: index.TransportMode ?? "fel", GoupeOfLines: index.GroupOfLine ?? "fel", Störninga: index.Deviations?[0].Text ?? "Inget")
            }
        }
        
    }
}

//struct TransportModeList_Previews: PreviewProvider {
//    static var previews: some View {
//        TransportModeList()
//    }
//}
