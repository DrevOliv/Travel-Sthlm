//
//  Visa&RedigeraVM.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-03-12.
//

import SwiftUI

struct Visa_RedigeraVM: View {
    
    @State var Avgång: String = "Inget"
    @State var Destination: String = "Inget"
    
    
    let width = UIScreen.main.bounds.size.width
    
    var body: some View {
        
            HStack{
                VStack(alignment: .leading, spacing: 7){
                    Text("Avgång:")
                        .font(.system(size: 14))
                        .underline()
                    
                    Text(Avgång)
                        .font(.system(size: 14))
                }
                
                Image(systemName: "arrow.forward")
                    .imageScale(.small)
                
                VStack(alignment: .leading, spacing: 7){
                    Text("Destination:")
                        .font(.system(size: 14))
                        .underline()
                        
                Text(Destination)
                    .font(.system(size: 14))
                }
//                Spacer()
            }
//            .frame(maxWidth: width*0.9)
//            .lineLimit(2)
            .padding()
            
            
        }

}

struct Visa_RedigeraVM_Previews: PreviewProvider {
    static var previews: some View {
        Visa_RedigeraVM()
    }
}
