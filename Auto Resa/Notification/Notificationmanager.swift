//
//  Notificationmanager.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-05-09.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager {
    
    static let instance = NotificationManager() //Singleton
    
    
    func requestAthNotification(completion: @escaping (Bool) -> Void) {
        
        let options: UNAuthorizationOptions = [.alert, .sound]
        
       UNUserNotificationCenter.current().requestAuthorization(options: options) { (state, error) in
            if let error = error {
                
                print("Error \(error)")
                
                
                
            } else if (state == true) {
                
                print("Notification Allowed")
                
                completion(state)
                
            } else if (state == false) {
                
                print("Notification Denied")
                
                completion(state)
                
            }
        
        }
        
        
        
    }
    
    func scheduleNotificatioCalendarAutoResa(tid: String, date: String, påmin_tid: Int, Trip_id: String, Product_name: String, Destination_name: String, completion: @escaping (scheduleNotification) -> Void) {
        
        let content = UNMutableNotificationContent()
        content.title = "Påminnelse, Trasport Avgång"
        content.body = "\(Product_name) mot \(Destination_name) avgår om \(påmin_tid) min" //", du har \(tid)min på dig"
        content.sound = .default
        
        
        // Convert And Add Påmintid
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "sw_SW") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: "\(date) \(tid)") else { return completion(.Failed) }
        
        
        guard let computed = Calendar.current.date(byAdding: .minute, value: -påmin_tid, to: date) else { return completion(.Failed)}
        
        print("\(Date()) < \(computed)")
        
        if (Date() < computed) {
            
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            let tids = dateFormatter.string(from: computed)
            
            let Tid_HM = tids.components(separatedBy: ":")
            
            // End
            
            // Setting date to
            var dateComponents = DateComponents()
            
            dateComponents.hour = Int(Tid_HM[0])
            dateComponents.minute = Int(Tid_HM[1])
            
            //print("2: HH: \(Int(Tid_HM[0])), mm: \(Int(Tid_HM[1]))")
            
            print(dateComponents)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            
            let request = UNNotificationRequest(identifier: Trip_id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print(error)
                    completion(.Failed)
                } else {
                    completion(.Complete)
                }
            }
            
        } else {
            completion(.UnderTime)
        }

        
    }
    
    enum scheduleNotification {
        case Complete
        case Failed
        case UnderTime
    }
    
    
    
    func ShowStationsNotificationSchedul(Time_Date: String, påmin_tid: String, TransportMode: String, LineNumber: String, Destination: String, completion: @escaping (scheduleNotification) -> Void) {
        print("1")
        
        guard let int_påmin_tid = Int(påmin_tid) else { return completion(.Failed) }
        
        print("2")

        
        
        let content = UNMutableNotificationContent()
        content.title = "Påminnelse, Trasport Avgång"
        content.body = " \(getSymbol(TransportMode)) \(LineNumber) mot \(Destination) avgår om \(int_påmin_tid) min."
        content.sound = .default
        print("3")
        
        // Convert And Add Påmintid
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "sw_SW") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: Time_Date) else { return completion(.Failed) }
        print("4 \(date) \(int_påmin_tid)")
        
        guard let computed = Calendar.current.date(byAdding: .minute, value: -int_påmin_tid, to: date) else { return completion(.Failed)}
        print("5 \(computed)")
        
        if (Date() < computed) {
            print("6")
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            let tids = dateFormatter.string(from: computed)
            
            let Tid_HM = tids.components(separatedBy: ":")
            
            // End
            
            // Setting date to
            var dateComponents = DateComponents()
            
            dateComponents.hour = Int(Tid_HM[0])
            dateComponents.minute = Int(Tid_HM[1])
            
            //print("2: HH: \(Int(Tid_HM[0])), mm: \(Int(Tid_HM[1]))")
            
            print(dateComponents)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print(error)
                    completion(.Failed)
                } else {
                    completion(.Complete)
                }
            }
            
        } else {
            completion(.UnderTime)
        }

        
    }
    
    
    func listNotifications(Id: String) -> Bool {
        print("Red Green 1")
        var state: Bool = false
        
        print("Red Green 2")
        
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { request in
            
            for i in request {
                print("Red Green 3 \(i)")
                if i.identifier == Id {
                    print("Red Green 4")
                    state = true
                }
            }
        })
        print("Red Green 5 \(state)")
        return state
        
    }
    
    
    
   private let getSymbol = { (string: String) -> String in
        
        switch string {
        case _ where string.contains("METRO"): return "Tunnelbana"
        case _ where string.contains("BUS"): return "Buss"
        case _ where string.contains("TRAIN"): return "Pendeltåg"
        case _ where string.contains("TRAM"): return "Spårvagn"
        case _ where string.contains("SHIP"): return "Båt"
        case _ where string.contains("FERRY"): return "Färja"
            
        default: return "square"
        }
        
        
    }
    
    
    
}

