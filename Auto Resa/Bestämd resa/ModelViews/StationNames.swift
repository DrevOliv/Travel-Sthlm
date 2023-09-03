//
//  StationNames.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-05-26.
//

import SwiftUI

struct StationNames: View {
    
    @State var index: trip? = nil
    let width = UIScreen.main.bounds.size.width
    
    var body: some View {
        
        HStack{
            HStack{
                TextFormate(text: index?.LegList?.Leg?.first?.Origin?.name ?? "Inget")
                    .font(.system(size: 15))

                Image(systemName: "arrow.forward")
                    .imageScale(.small)

                TextFormate(text: index?.LegList?.Leg?.last?.Destination?.name ?? "Inget")
                    .font(.system(size: 15))

                Spacer()
            }
            .frame(maxWidth: width*0.8)
            .lineLimit(1)

            Spacer()

        }
    }
}

struct StationNames_Previews: PreviewProvider {
    static var previews: some View {
        StationNames()
    }
}
