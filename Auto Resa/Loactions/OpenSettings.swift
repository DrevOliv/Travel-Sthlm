//
//  OpenSettings.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-03-24.
//

import SwiftUI

struct OpenSettings: View {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        
            VStack{
                Text("Öppna Inställningar och Tillåt Appen Använda Platsinfo")
                    .multilineTextAlignment(.center)
                    .font(.title3)
                Text(
                    "Din platsinfo kommer bara att användas för att hitta potentiella stationer nära dina plats, inom en radie på 1000 meter som senare uppdateringar kommer kunna ändras. Informationen används temporärt och sparas ej.")
                    .frame(width: screenWidth*0.9)
                    .multilineTextAlignment(.center)
                    .font(.caption2)
                    .padding()
                
                Link(destination: URL(string: "app-settings:root=General&path=About")!) {
                    Image(systemName: "gear.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70)
                        .foregroundColor(Color.blue)
                }

                
            }

        }
    
}

struct OpenSettings_Previews: PreviewProvider {
    static var previews: some View {
        OpenSettings()
    }
}
