//
//  test.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-04-25.
//

import SwiftUI

struct test: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0 ..< 200) { index in
                    Text("Hello World \(index)").font(.title2)
                }
                .background(
                    GeometryReader { geometry in
                        Color.pink.opacity(0).border(Color.blue, width: 2).cornerRadius(10)
                            .execute {
                                let offset = geometry.frame(in: .named("scroll")).minY
                                print(Int(offset))
                            }
                    }
                )
            }
            .coordinateSpace(name: "scroll")
        }
    }
}

extension View {
    func execute(callback: @escaping () -> Void) -> some View {
        callback()
        return self
    }
}
struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}


