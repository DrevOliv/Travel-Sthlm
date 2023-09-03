//
//  testview.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-05-28.
//

import SwiftUI

struct TestView: View {
    
    @State private var currentTab: Tabs = .Scan
    
    enum Tabs {
        case Scan, Validate, Settings
        
        
        var title: String {
            
            switch self {
            case .Scan:
                return "Scan"
            case .Validate:
                return "Validate"
            case .Settings:
                return "Settings"
            }
            
        }
        
        
        var description: some View {

          switch self {
          // Use Internationalization, as appropriate.
          case .Scan : return (
              Button("hej") {
                  return
              }
          )


          case .Validate : return (
            Button("hej") {
                return
            }
          )
              
          case .Settings : return (
              Button("hej Då") {
                  return
              }
          )

          }
        }
        
    }
    
    var body: some View {
        NavigationView{
            
        TabView(selection: $currentTab){
            
            TestListSwipe()
                .tabItem {
                    Label(Tabs.Scan.title, systemImage: "square.and.pencil")
                }
                .tag(Tabs.Scan)
            
            Navigationlink()
                .tabItem {
                    Label(Tabs.Validate.title, systemImage: "list.dash")
                }
                .tag(Tabs.Validate)
            
            SwiftUIView()
                .tabItem {
                    Label(Tabs.Settings.title, systemImage: "list.dash")
                }
                .tag(Tabs.Settings)
        }
        .navigationBarTitle(Text(currentTab.title))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
            currentTab.description
            
//            HStack{
//                NavigationLink(destination: {Text("hejhhshfjdfjdfjd")}) {
//                    Text("Gå Till NavLink")
//                }
//                ToolbarItem{
//                    Button(action: {
//                        return
//                    }, label: {
//                        Image(systemName: "arrowshape.turn.up.right.circle")
//                    })
//                }
//            }
        }
        }

        
//        .navigationViewStyle(StackNavigationViewStyle())
    }
        .navigationViewStyle(StackNavigationViewStyle())
//        .onAppear{
//            print(Foo.description)
//        }
    }

}


enum Foo {
  case Bing
  case Bang
  case Boom

  var description: some View {

    switch self {
    // Use Internationalization, as appropriate.
    case .Bing: return (
        Button("hej") {
            return
        }
    )


    case .Bang: return (
        Button("Då") {
            return
        }
    )
        
    case .Boom: return (
        Button("hej Då") {
            return
        }
    )

    }
  }
}



//, displayMode: .inline

//
//@State var tabSelection: Tabs = .tab1
//
//var body: some View {
//
//        TabView(selection: $tabSelection){
//
//                NavigationView{ //if you write the NavigationView here, you cannot remove TabBar after navigation
//            NavigationLink(destination: {Text("hej hej hej hej hej")}){
//                    VStack{
//                        Text("Here is Tab 1")
//                        Text("Tap me to NavigatedView")
//                    }
//                    .navigationBarTitle("Tab1")//NavigationBarTitle does not work here
//                }
//                }
//                .tabItem { Text("Tab 1") }
//            .tag(Tabs.tab1)
//
//                NavigationView{//Tab2 also has a NavigationView
//                NavigationLink(destination: SwiftUIView()){
//                    VStack{
//                        Text("Here is Tab 2")
//                        Text("Tap me to NavigatedView")
//                    }
//                    .navigationBarTitle("Tab2")//NavigationBarTitle does not work here
//                }
//                }
//                .tabItem { Text("Tab 2") }
//            .tag(Tabs.tab2)
//        }
//
//}
//
//enum Tabs{
//    case tab1, tab2
//}
//}
