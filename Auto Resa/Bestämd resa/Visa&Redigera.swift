//
//  Visa&Redigera.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-03-12.
//

import SwiftUI

struct Visa_Redigera: View {
    
    @EnvironmentObject var vmCoreData: CoreDataManager
    
    @State var SpakaResaNav = false
    
    var body: some View {
        Group{

            if (vmCoreData.savedStationer.isEmpty){
                VStack {
                    Text("Inga Stationer Finns")
                    NavigationLink(destination: SkapaStationSamling(SpakaResaNav: $SpakaResaNav),isActive: $SpakaResaNav){
                        Text("Skapa Resa")
                            .padding()
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    }

                }
//                .padding()
//                .padding()
//                .padding([.top, .bottom])
//                .background(RoundedRectangle(cornerRadius: 30).fill(Color.white).shadow(color: Color.gray, radius: 3, x: 0, y: 0))
            } else {
                VStack {
                    List{
                        ForEach(vmCoreData.savedStationer){ index in
                            Visa_RedigeraVM(Avgång: index.avgang ?? "Inget", Destination: index.destination ?? "Inget")
                        }.onDelete(perform: vmCoreData.deleteStationer)
                    }
                }
            }
        }
        .navigationTitle("Sparade Stationer")
        .toolbar {

            ToolbarItemGroup {
                HStack {
                    HStack{
                        
                    EditButton()
                    }
                    NavigationLink(destination: SkapaStationSamling(SpakaResaNav: $SpakaResaNav),isActive: $SpakaResaNav){
                        HStack{
                            Image(systemName: "plus.circle.fill").imageScale(.large)
                            Text("Skapa Resa")
                        }
                    }
                }
            }
        }
    }
}

struct Visa_Redigera_Previews: PreviewProvider {
    static var previews: some View {
        Visa_Redigera()
    }
}
