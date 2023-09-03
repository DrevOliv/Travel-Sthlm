//
//  CustomAlert.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-05-11.
//


import SwiftUI

struct FloatingNotice: View {
    
    @Binding var showingNotice: Bool

    var body: some View {
        withAnimation {
            VStack (alignment: .center, spacing: 8) {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 48, weight: .regular))
                    .padding(5)
                Text("Påminnelse Har Sats")
                    .foregroundColor(.white)
                    .font(.callout)
            }
            .padding()
            .background(Color.gray.opacity(0.95).cornerRadius(10))
        }

        .transition(.opacity)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                withAnimation {
                    self.showingNotice = false
                }
                
            })
        })
    }
}


