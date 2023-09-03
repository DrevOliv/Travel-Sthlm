//
//  Annotation.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-08-18.
//

import SwiftUI

struct Annotation: View {
    
    @State var name: String = "Slussen"
    @State var Id: String = "4001"
    @State var weight: Int = 15496
    @State var products: Int = 74
    @State var show: Bool = true
    
    @Binding var selectedName: String
    @Binding var selectedId: String
    @Binding var SelectedFromMap: Bool
//    @State var selectedName: String = "Inget"
//    @State var selectedId: String = "Inget"
    
    var body: some View {
//        ZStack{
//            Rectangle()
            
            VStack{
                
                if show {
                    VStack{
                        VStack {
                            Text(name)
                                .font(.system(size: 12))
                                .offset( y: -2)
                            if name == selectedName {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 10))
                                    .offset( y: 4)
                                    .foregroundColor(Color.blue)
                                    
                            } else {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 10))
                                    .offset( y: 4)
                                    .foregroundColor(Color.gray)
                            }

                        }
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.white).shadow(color: Color.gray, radius: 10, x: 0, y: 0))
                        .onTapGesture {
                            if name == selectedName {
                                selectedName = "Inget"
                                SelectedFromMap = false
                            } else {
                                selectedName = name
                                SelectedFromMap = true
                            }
                            
                            if Id == selectedId {
                                selectedId = "Inget"
                            } else {
                                selectedId = Id
                            }
                        }
                        Image(systemName: "triangle.fill")
                            .foregroundColor(Color.white)
                            .rotationEffect(Angle(degrees: 180))
                            .offset(y: -5)
                        
                    }
                    .offset(y: -20)

                    
                    
                }
                else {
                    EmptyView()
                }
            }
            .onChange(of: SelectedFromMap) { newValue in
                print(newValue)
            }
            
            
//        }
            
            
            
            
            
//            VStack{
//                if !taped {
//                    withAnimation {
//
//                        VStack {
//                            Text(name)
//                        }
//                        .padding()
//                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//                    }.transition(.scale)
//
//                } else {
//                    withAnimation {
//
//                        VStack {
//                            Text(name)
//                            Text(name)
//                            Text(name)
//                        }
//                        .padding()
//                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//
//                    }.transition(.scale)
//                }
//
//                Image(systemName: "triangle.fill")
//                    .foregroundColor(Color.white)
//                    .rotationEffect(Angle(degrees: 180))
//                    .offset(y: -5)
//            }
//            .offset(y: -20)
//            .onTapGesture {
//                withAnimation {
//                    taped.toggle()
//                }
//
//            }
    }
}

//struct Annotation_Previews: PreviewProvider {
//    static var previews: some View {
//        Annotation()
//    }
//}
