//
//  SwiftUIView.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-05-11.
//

import SwiftUI
import MapKit

struct SwiftUIView: View {
    
    @State var välj_tid = true
    
//    "45", "25", "15", "5"
    @State var Notifi_Alternativ = [
        ""
    ]
    
    var body: some View {
        Group{
        VStack{
            Text("HEJ hej HEJ hej")
            VStack{
                
                Text("Hej")
                
                
                
                
            }
        
        }
        .navigationTitle("hej")
        }
        .alert("Välj Tid", isPresented: $välj_tid ){
            VStack{
                ForEach(Notifi_Alternativ, id: \.self) { alternativ in
                    
                    Button("\(alternativ) min") {
                        return
                    }
                    
                }
            }
        }
    }
    


    
    
    
    
        
//
//
//
//        let str = "2022-04-29T06:54:00"
//
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "sw_SW")
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        formatter.timeZone = calendar.timeZone
//        print(formatter.date(from: str) ?? Date())
                

//    func Time() -> Date {
//        let calendar = Calendar(identifier: .gregorian)
//        let currentDate = Date()
////        print(calendar.dateComponents(in: calendar.timeZone, from: currentDate))
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:Z"
//        dateFormatter.timeZone = calendar.timeZone
//        print(dateFormatter.string(from: currentDate))
//
//
//        let str = "2022-04-29T06:54:00"
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        formatter.timeZone = calendar.timeZone
//        return formatter.date(from: str) ?? Date()
//
//    }
    
}


//struct FloatingNotice: View {
//
//    @Binding var showingNotice: Bool
//
//    var body: some View {
//        VStack (alignment: .center, spacing: 8) {
//            Image(systemName: "checkmark")
//                .foregroundColor(.white)
//                .font(.system(size: 48, weight: .regular))
//                .padding(EdgeInsets(top: 20, leading: 5, bottom: 5, trailing: 5))
//            Text("Påminnelse Har Sats")
//                .foregroundColor(.white)
//                .font(.callout)
//                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
//        }
//        .background(Color.gray.opacity(0.65))
//        .cornerRadius(5)
//        .transition(.opacity)
//        .onAppear(perform: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                withAnimation {
//                    self.showingNotice = false
//                }
//
//            })
//        })
//    }
//}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

