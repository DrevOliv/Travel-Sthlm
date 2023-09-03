//
//  ListView.swift
//  tutorial meme widget app
//
//  Created by Oliver Drevet on 2022-01-10.
//

import SwiftUI

struct ListView: View {
    
    var title: String = "Hej"
    var id: String = "Något"
    
    @Binding var selectedItem: String
    @Binding var stationID: String
    
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            if title == selectedItem {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if title == selectedItem {
                selectedItem = "Inget"
            } else {
                selectedItem = title
            }
            
            if id == stationID {
                stationID = "Inget"
            } else {
                stationID = id
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    
    @State static var selectedItem: String = "Inget"
    @State static var stationID: String = "Inget"
    
    static var previews: some View {
        ListView(selectedItem: $selectedItem, stationID: $stationID)
    }
}

