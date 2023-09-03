//
//  ViewModifire.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-06-13.
//
import Foundation
import SwiftUI



extension View {
    
    func AlertCustom (Bindning: Binding<Bool>, Title: String, Message: String, ButtonOne: String) -> some View {
        modifier(alertacustom(Bindning: Bindning, Title: Title, Message: Message, ButtonOne: ButtonOne))
    }
    
    func SwipeNotification (list: trip, intervalNoti: Int, NotificationFel: Binding<Bool>, NotificationUnderTime: Binding<Bool>, HarSattPåminnelse: Binding<Bool>, TilllåtaNotification: Binding<Bool>) -> some View {
        
        modifier(swipenotification(list: list, intervalNoti: intervalNoti, NotificationFel: NotificationFel, NotificationUnderTime: NotificationUnderTime, HarSattPåminnelse: HarSattPåminnelse, TilllåtaNotification: TilllåtaNotification))
        
    }
    
}





struct alertacustom: ViewModifier {
    
    let Bindning: Binding<Bool>
    let Title: String
    let Message: String
    
    let ButtonOne: String
    
    
    func body(content: Content) -> some View {
        content
            .alert(Title, isPresented: Bindning) {
                VStack{
                    Button(ButtonOne) {
                        
                    }
                }
            } message: {
                Text(Message)
            }
    }
}

struct swipenotification: ViewModifier {
    
    let list: trip
    let intervalNoti: Int
    @Binding var NotificationFel: Bool
    @Binding var NotificationUnderTime: Bool
    @Binding var HarSattPåminnelse: Bool
    @Binding var TilllåtaNotification: Bool
    
    func body(content: Content) -> some View {
        content
            .swipeActions(edge: .trailing) {
                Button {
                    
                    NotificationManager.instance.requestAthNotification(completion: { State in
                        if (State) {
                            
                            
                            NotificationManager.instance.scheduleNotificatioCalendarAutoResa(
                                tid: list.LegList?.Leg?.first?.Origin?.time ?? "",
                                date: list.LegList?.Leg?.first?.Origin?.date ?? "",
                                påmin_tid: intervalNoti,
                                Trip_id: list.LegList?.Leg?.first?.JourneyDetailRef?.ref ?? "",
                                Product_name: list.LegList?.Leg?.first?.Product?.name ?? "",
                                Destination_name:  list.LegList?.Leg?.first?.Destination?.name ?? "") { state in
                                    
                                    if state == .Failed {
                                        NotificationFel = true
                                        
                                    } else if state == .UnderTime {
                                        NotificationUnderTime = true
                                        
                                    } else if state == .Complete {
                                        
                                        withAnimation {
                                            HarSattPåminnelse = true
                                        }
                                        
                                        print("Schedualed notification")
                                        
                                    }
                                }
                            
                            
                        } else {
                            TilllåtaNotification = true
                            print("Not sending")
                        }
                                                                        
                    })
                    
                } label: {
                    Label("Påmin", systemImage: "bell.fill")
                }
                .tint(Color.green)
            }
    }
}




