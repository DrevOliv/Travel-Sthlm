//
//  Allow locations.swift
//  Auto Resa
//
//  Created by Oliver Drevet on 2022-02-23.
//

import SwiftUI

struct Allow_locations: View {
    
    @ObservedObject var locationManager = LocationManager.shered
    
    var body: some View {
        VStack(spacing: 100){
            Image(systemName: "location.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(Color.blue)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white).shadow(color: Color.gray, radius: 5, x: 0, y: 0))
            
    
            Button("Tillåt Plats Info") {
                locationManager.requestLocation()
            }
            .foregroundColor(Color.white)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue).shadow(color: Color.gray, radius: 5, x: 0, y: 5))
            
            
        }
    }
}

struct Allow_locations_Previews: PreviewProvider {
    static var previews: some View {
        Allow_locations()
    }
}
