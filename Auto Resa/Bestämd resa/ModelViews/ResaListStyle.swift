//
//  ResaListStyle.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-05-26.
//

import SwiftUI

struct ResaListStyle: View {
    
    @State var index: trip? = nil
    
    var body: some View {
        
        StationNames(index: index)

        HStack{
            HStack{
            TimeFormate(TimeOrigin: index?.LegList?.Leg?.first?.Origin?.time ?? "Inget", TimeDestination: index?.LegList?.Leg?.last?.Destination?.time ?? "Inget", RTimeOrigin: index?.LegList?.Leg?.first?.Origin?.rtTime ?? nil, RTimeDestination: index?.LegList?.Leg?.first?.Destination?.rtTime ?? nil)
            }
            Spacer()

        }
        .padding(.top, 2)

        HStack{

                ForEach((index?.LegList?.Leg ?? []).prefix(7)){ index2 in
                    ListVisaResorModel(type: index2.type ?? "Inget", name: index2.name ?? "Inget", catOut: index2.Product?.catOut ?? "Inget")
                    
            }

            Spacer()

        }

        HStack{
            ForEach(index?.LegList?.Leg ?? []) { index2 in
                if (index2.Messages?.Message?.first?.text ?? "" == ""){
                    EmptyView()
                } else {
                    Message(text: index2.Messages?.Message?.first?.text ?? "")
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 255/255, green: 99/255, blue: 38/255))
//                                                            .frame(maxWidth: width*0.8)

                            .padding(.top)
                }
            }

        }
        
    }
}

struct ResaListStyle_Previews: PreviewProvider {
    static var previews: some View {
        ResaListStyle()
    }
}
