//
//  ShowStations.swift
//  Auto Resa
//
//  Created by Oliver Drevet on 2022-03-01.
//

import SwiftUI

struct ShowStations: View {
    
    var api = Api()
    
    @State var StationNamn: String = "Inget"
    @State var ExtenId: String = "Inget"
    @State var Longitude: String = "Inget"
    @State var Latitude: String = "Inget"
    
    @State var Id: String = "7085"
    
    @State var EttFel = false
    @State var Loading = false
    @State var Cancel = false
    @State var Har_Sökt = false
    
    @State var avgångar: Avgångar?
    
    @State var Alternativ = ["Buss"]
    @State var Valda = "Buss"
    
    @State var NotificationFel = false
    @State var TilllåtaNotification = false
    @State var HarSattPåminnelse = false
    @State var NotificationUnderTime = false
    @State var SättAvgångTid = true
    @State var TidInannAvgång = "Inget"
    @State var välj_tid = false
    
    @State var Notifi_Alternativ = [""]
    
    
    var body: some View {
        ZStack {
            Group {
                if (Loading){
                    ProgressView()
                        
                } else if (Cancel){
                    Text("Ett Fel Inträffade!")
                        .font(.title2)
                } else {
                    
                    VStack {
                        Group {
                            if (Alternativ.isEmpty != true) {
                                Picker("Transportmedel", selection: $Valda) {
                                    ForEach(Alternativ, id: \.self) { flavor in
                                        Text(flavor)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .padding(.top)

                        
                        
//                            if (Har_Sökt == true){
//                                Spacer()
//                                Text("Inga resor hittades")
//                                Spacer()
//                            }
                             if(Valda == "Buss") {
                                List(avgångar?.ResponseData?.Buses ?? []){ index in
                                    ZStack{
//                                        NavigationLink {
//                                            Text("FUNKAR")
//                                        } label: {
//                                            EmptyView()
//                                        }

                                    ListViewStationer(Från_B: index.StopAreaName ?? "fel" ,Till_B: index.Destination ?? "fel", Tid_B: index.TimeTabledDateTime ?? "fel", PredictedTid_B: index.ExpectedDateTime ?? "fel", LineNumb: index.LineNumber ?? "fel", TransportMode: index.TransportMode ?? "fel", GoupeOfLines: index.GroupOfLine ?? "fel", Störninga: index.Deviations?[0].Text ?? "Inget")
                                    }
                                    
                                    
                                    .swipeActions(edge: .trailing) {
                                        SwipeActionFunc(TimeTabledDateTime: index.TimeTabledDateTime ?? "Inget")
                                    }
                                    
                                    .alert("Välj Tid", isPresented: $välj_tid ){
                                        
                                        SwipeActionAlert(TimeTabledDateTime: index.TimeTabledDateTime ?? "", TransportMode: index.TransportMode ?? "", LineNumber: index.LineNumber ?? "", Destination: index.Destination ?? "")
                                        
                                    } message: {
                                        Text("Påminn antal min innan åker avgång")
                                    }
                                                                        
                                }
                                .listStyle(.inset)
                                .refreshable{
                                    print("Säker avgångar igen")
                                    get_stationId(Hela: ExtenId)
                                    
                                }
                                
                            } else if(Valda == "Tunnelbana") {
                                
                                List(avgångar?.ResponseData?.Metros ?? []){ index in
                                    ZStack{
                                    ListViewStationer(Från_B: index.StopAreaName ?? "fel" ,Till_B: index.Destination ?? "fel", Tid_B: index.TimeTabledDateTime ?? "fel", PredictedTid_B: index.ExpectedDateTime ?? "fel", LineNumb: index.LineNumber ?? "fel", TransportMode: index.TransportMode ?? "fel", GoupeOfLines:index.GroupOfLine ?? "fel", Störninga: index.Deviations?[0].Text ?? "Inget")
                                    }
                                    .swipeActions(edge: .trailing) {
                                        SwipeActionFunc(TimeTabledDateTime: index.TimeTabledDateTime ?? "Inget")
                                    }
                                    .alert("Välj Tid", isPresented: $välj_tid ){
                                        
                                        SwipeActionAlert(TimeTabledDateTime: index.TimeTabledDateTime ?? "", TransportMode: index.TransportMode ?? "", LineNumber: index.LineNumber ?? "", Destination: index.Destination ?? "")
                                        
                                    } message: {
                                        Text("Påminn antal min innan åker avgång")
                                    }
                                        
                                }
                                .listStyle(.inset)
                                .refreshable{
                                    get_stationId(Hela: ExtenId)
                                }
                                
                            } else if(Valda == "Pendeltåg") {
                                List(avgångar?.ResponseData?.Trains ?? []){ index in
                                    ZStack{
                                    ListViewStationer(Från_B: index.StopAreaName ?? "fel" ,Till_B: index.Destination ?? "fel", Tid_B: index.TimeTabledDateTime ?? "fel", PredictedTid_B: index.ExpectedDateTime ?? "fel", LineNumb: index.LineNumber ?? "fel", TransportMode: index.TransportMode ?? "fel", GoupeOfLines:index.GroupOfLine ?? "fel", Störninga: index.Deviations?[0].Text ?? "Inget")
                                    }
                                    .swipeActions(edge: .trailing) {
                                        SwipeActionFunc(TimeTabledDateTime: index.TimeTabledDateTime ?? "Inget")
                                    }
                                    .alert("Välj Tid", isPresented: $välj_tid ){
                                        
                                        SwipeActionAlert(TimeTabledDateTime: index.TimeTabledDateTime ?? "", TransportMode: index.TransportMode ?? "", LineNumber: index.LineNumber ?? "", Destination: index.Destination ?? "")
                                        
                                    } message: {
                                        Text("Påminn antal min innan åker avgång")
                                    }
                                        
                                }
                                .listStyle(.inset)
                                .refreshable{
                                    get_stationId(Hela: ExtenId)
                                }
                                
                            } else if(Valda == "Tvärbana") {
                                List(avgångar?.ResponseData?.Trams ?? []){ index in
                                    ZStack{
                                    ListViewStationer(Från_B: index.StopAreaName ?? "fel" ,Till_B: index.Destination ?? "fel", Tid_B: index.TimeTabledDateTime ?? "fel", PredictedTid_B: index.ExpectedDateTime ?? "fel", LineNumb: index.LineNumber ?? "fel", TransportMode: index.TransportMode ?? "fel", GoupeOfLines:index.GroupOfLine ?? "fel", Störninga: index.Deviations?[0].Text ?? "Inget")
                                    }
                                    .swipeActions(edge: .trailing) {
                                        SwipeActionFunc(TimeTabledDateTime: index.TimeTabledDateTime ?? "Inget")
                                    }
                                    .alert("Välj Tid", isPresented: $välj_tid ){
                                        
                                        SwipeActionAlert(TimeTabledDateTime: index.TimeTabledDateTime ?? "", TransportMode: index.TransportMode ?? "", LineNumber: index.LineNumber ?? "", Destination: index.Destination ?? "")
                                        
                                    } message: {
                                        Text("Påminn antal min innan åker avgång")
                                    }
                                }
                                .listStyle(.inset)
                                .refreshable{
                                    get_stationId(Hela: ExtenId)
                                }
                                
                            } else if (Valda == "Båt") {
                                List(avgångar?.ResponseData?.Ships ?? []){ index in
                                    ZStack{
                                    ListViewStationer(Från_B: index.StopAreaName ?? "fel" ,Till_B: index.Destination ?? "fel", Tid_B: index.TimeTabledDateTime ?? "fel", PredictedTid_B: index.ExpectedDateTime ?? "fel", LineNumb: index.LineNumber ?? "fel", TransportMode: index.TransportMode ?? "fel", GoupeOfLines:index.GroupOfLine ?? "fel", Störninga: index.Deviations?[0].Text ?? "Inget")
                                    }
                                    .swipeActions(edge: .trailing) {
                                        SwipeActionFunc(TimeTabledDateTime: index.TimeTabledDateTime ?? "Inget")
                                    }
                                    .alert("Välj Tid", isPresented: $välj_tid ){
                                        
                                        SwipeActionAlert(TimeTabledDateTime: index.TimeTabledDateTime ?? "", TransportMode: index.TransportMode ?? "", LineNumber: index.LineNumber ?? "", Destination: index.Destination ?? "")
                                        
                                    } message: {
                                        Text("Påminn antal min innan åker avgång")
                                    }
                                }
                                .listStyle(.inset)
                                .refreshable{
                                    get_stationId(Hela: ExtenId)
                                }
                                
                            }
                            } else {
                                
                                
                                VStack(spacing: 20){
                                    Text("Inga Resor")
                                        .font(.title2)
                                    Button {
                                        get_stationId(Hela: ExtenId)
                                    } label: {
                                        Image(systemName: "arrow.clockwise")
                                            .foregroundColor(Color.blue)
                                            .font(.system(size: 30))
                                    }

                                }
                                
                            }

                        }
                    }
                }
            }
            .zIndex(0)
            
            if HarSattPåminnelse {
                FloatingNotice(showingNotice: $HarSattPåminnelse)
                    .zIndex(1)
            }

            
        }            .navigationTitle(StationNamn)
        .alert("Ett fel inträffade", isPresented: $EttFel) {
                HStack{
                    Button("Prova igen") {
                        get_stationId(Hela: ExtenId)
                    }
                    Button("Avbryt") {Cancel = true}
                }
        } message: {
            Text("Kunde inte hitta några resor")
        }
        
        .alert("Ett fel inträffa", isPresented: $NotificationFel) {
            Button("Avbryt") {
                
            }
        } message: {
            Text("Kunde inte sätta påminnelse")
        }
        
        .alert("Kunde inte sätta påminnelse", isPresented: $TilllåtaNotification) {
            Button("fortsätt") {
                
            }
            Link("Öppna Inställningar", destination: URL(string: "app-settings:root=General&path=About")!)
        } message: {
            Text("Måste tillåta påminnelse, för att sätta påminnelse")
        }
        
        
        .alert("Fel", isPresented: $NotificationUnderTime) {
            Button("Fortsätt"){
                
            }
        } message: {
            Text("Kunde inte sätta påminnelse, tiden är för kort")
        }
        
        
        .onAppear{
            get_stationId(Hela: ExtenId)
        }

    }
    
//    struct test: ViewModifier {
//        func body(content: Content) -> some View {
//            content
//                .padding()
//        }
//    }
    
    
//    func Get_time_have(Station_tid: String) {
//        
//        let idag = Date()
//        
//        
//        // Convert And Add Påmintid
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "sw_SW") // set locale to reliable US_POSIX
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        guard let date = dateFormatter.date(from: Station_tid) else { return "fel"}
//        
//        let interval = date - idag
//        
//        return interval
//        
//    }
    
    func SwipeActionAlert(TimeTabledDateTime: String, TransportMode: String, LineNumber: String, Destination: String) -> some View {
        VStack{
            ForEach(Notifi_Alternativ, id: \.self) { alternativ in
                VStack{
                    Button("\(alternativ) min") {
                        
                        NotificationManager.instance.ShowStationsNotificationSchedul(Time_Date: TimeTabledDateTime, påmin_tid: alternativ, TransportMode: TransportMode, LineNumber: LineNumber, Destination: Destination){ state in
                            
                            if state == .Complete {
                                withAnimation {
                                    HarSattPåminnelse = true
                                }
                            } else if state == .Failed {
                                NotificationFel = true
                            }
                        }
                        
                    }
                }
            }
            Button("Avbryt") {
                
            }
        }
    }
        
    
    func SwipeActionFunc(TimeTabledDateTime: String) -> some View {
        Button {
            NotificationManager.instance.requestAthNotification(completion: { State in
                if (State) {
                    
                    let interval = Get_time_have(Station_tid: TimeTabledDateTime)
                    
                    if interval.Success == false {
                        NotificationFel = true
                    } else if interval.Success {
                        
                        Set_alternativ_notification(TidInterval: interval.Time)
                        
                    }
                    

                                                                        
                } else {
                    
                    TilllåtaNotification = true
                    print("Not sending")
                    
                }
            })
            
        } label: {
            Label("Påminn", systemImage: "bell.fill")
        }
        .tint(Color.green)
    }
    
//    var SwipeActionFunc: some View {
//
//
//    }
    
    
    func Set_alternativ_notification(TidInterval: Double) {
        
    
        if TidInterval > 45 + 1 {
            Notifi_Alternativ = [
                "45", "25", "15", "5"
            ]
            välj_tid = true
        } else if TidInterval > 25 + 1 {
            Notifi_Alternativ = [
                "25", "15", "5"
            ]
            välj_tid = true
        } else if TidInterval > 15 + 1 {
            Notifi_Alternativ = [
                "15", "5"
            ]
            välj_tid = true
        } else if TidInterval > 5 + 1 {
            Notifi_Alternativ = [
                "5"
            ]
            välj_tid = true
        } else {
            NotificationUnderTime = true
        }
        
    }
    
    
    func Get_time_have(Station_tid: String) -> (Time: Double, Success: Bool) {
        
//        ex: let str = "2022-05-22T14:00:00"
        
        let idag = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "sw_SW")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: Station_tid) else { return (0, false) }
            
        
        let delta = date.timeIntervalSince(idag)
        
        print("Schedule Notification Get_time_have \(delta/60)")
        
        return (delta/60, true)
        
    }
    
    
    
    
    
    func Set_Options() {
                
        Alternativ = []
        
        if(avgångar?.ResponseData?.Buses?.isEmpty != true){
            Alternativ.append("Buss")
        }
        if (avgångar?.ResponseData?.Metros?.isEmpty != true){
            Alternativ.append("Tunnelbana")
        }
        if (avgångar?.ResponseData?.Trains?.isEmpty != true) {
            Alternativ.append("Pendeltåg")
        }
        if (avgångar?.ResponseData?.Trams?.isEmpty != true) {
            Alternativ.append("Tvärbana")
        }
        if (avgångar?.ResponseData?.Ships?.isEmpty != true) {
            Alternativ.append("Båt")
        }
        
        
        Valda = Alternativ.first ?? "Buss"
        
        
        
        Loading = false
        
    }
        
    func get_stationId(Hela: String){
        Loading = true
        
        if (ExtenId != "Inget" && ExtenId.count != 0) {
            var separerad = Hela.map{ String($0) }
            
            if (separerad.count > 5) {
                separerad.removeSubrange(0..<5)
                let nya = separerad.joined(separator: "")
                
                SökAvgångar(Id: nya)
            }
            
        } else {
            HapticManager.instance.notification(type: .error)
            EttFel = true
        }
    }
    
    func SökAvgångar(Id: String) {
        
        if (Id.count >= 4 && Id != "Inget"){
            
            
//            let id = "1080"
            
            api.getAvgångar(SiteId: Id, TimeWindow: "25") { Avgångar in
                self.avgångar = Avgångar
                HapticManager.instance.notification(type: .success)
                if (api.getAvgångar_fel == true) {
                    EttFel = true
                }
                
                Set_Options()
            }
            
        } else {
            HapticManager.instance.notification(type: .error)
            EttFel = true
        }
    }
    
}

struct ShowStations_Previews: PreviewProvider {
    static var previews: some View {
        ShowStations()
    }
}


