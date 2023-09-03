//
//  ListViewStationer.swift
//  Auto Resa
//
//  Created by Oliver Drevet on 2022-03-01.
//

import SwiftUI

struct ListViewStationer: View {
    
    @State var Från_B: String = "Huddinge"
    @State var Till_B: String = "Fruängen"
    
    @State var Tid_B: String = "2022-03-01T13:38:15"
    @State var PredictedTid_B: String = "2022-03-01T13:39:30"
    
    @State var LineNumb: String = "704"
    @State var TransportMode: String = "BUS"
    @State var GoupeOfLines = ""
    
    @State var Störninga: String = "Inget"
    
    let width = UIScreen.main.bounds.size.width
    
    var body: some View {
        ZStack {
            VStack(spacing: 13) {
                HStack {
                    HStack {
                        Text(Från_B)
                            .font(.system(size: 15))
                        
                        Image(systemName: "arrow.right")
                            .imageScale(.small)
                        
                        Text(Till_B)
                            .font(.system(size: 15))
                        Spacer()
                    }
                    .frame(width: width-140,alignment: .leading)
                    
                        .lineLimit(1)
                    Spacer()
                }
                
                HStack{
                    Get_time(Tid: Tid_B, PredictedTid: PredictedTid_B)
                    Spacer()
                }
                Group{
                    if (Störninga != "" && Störninga != "Inget") {
                        HStack{
                            Text(Störninga)
                                .font(.caption)
                                .foregroundColor(Color(red: 255/255, green: 99/255, blue: 38/255))
                                .frame(width: width-140,alignment: .leading)
                            
                            Spacer()
                        }
                    }
                }
            }
            HStack {
                Spacer()
                GetSymbol(LineNumb: LineNumb, TransportMode: TransportMode, GoupeOfLines: GoupeOfLines)
                
            }
        }.padding()
        
//        .background(RoundedRectangle(cornerRadius: 5).fill(Color.white).shadow(color: Color.gray, radius: 1, x: 0, y: 0))
        
    }
}

struct ListViewStationer_Previews: PreviewProvider {
    static var previews: some View {
        ListViewStationer()
    }
}
