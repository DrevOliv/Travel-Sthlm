//
//  TestListSwipe.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-04-27.
//

import SwiftUI

struct TestListSwipe: View {
    var body: some View {
        List {
            ForEach(1..<100) { i in
                Text("\(i)")
                    .swipeActions(edge: .leading) {
                        Button {
                            return
                        } label: {
                            Label("Add \(i)", systemImage: "plus.circle")
                        }
                        .tint(.indigo)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            return
                        } label: {
                            Label("Subtract \(i)", systemImage: "minus.circle")
                        }
                    }
            }
        }
    }
}

struct TestListSwipe_Previews: PreviewProvider {
    static var previews: some View {
        TestListSwipe()
    }
}
