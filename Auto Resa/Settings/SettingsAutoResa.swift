//
//  Settings.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-05-11.
//

import SwiftUI


class SettingClass {
    
    
    struct SettingsAutoResa: View {
        
        @AppStorage("AutoPåminnelseAvgång") var AutoPåminnelseAvgång = 15
        @AppStorage("SearchRadius") var SearchRadius = 1000
        
        @State var Finjustering: Bool = false
        
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            NavigationView {
                
                Form{
                    
                    Section {
                        Stepper("\(AutoPåminnelseAvgång) min", value: $AutoPåminnelseAvgång, in: 1...60) { bool in
                            if bool {
                                HapticManager.instance.impact(style: .medium)
                            }
                        }
                        
                        
                    } header: {
                        Text("Påminn antal min inan avgång")
                    }
                    
                    Section {
                        Stepper("\(SearchRadius) meter", value: $SearchRadius, in: 1...2000, step: Finjustering ? 50 : 500) { bool in
                            if bool {
                                HapticManager.instance.impact(style: .medium)
                            }
                        }
                        
                        Toggle("Finjustering", isOn: $Finjustering)
                        
                    } header: {
                        Text("Radiestorlek där stationer söks i")
                    }
                    
                    
                }
                .navigationTitle("Inställningar")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Image(systemName: "x.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.blue)
                            .onTapGesture{
                                presentationMode.wrappedValue.dismiss()
                                
                                
                            }
                    }
                }
            }
            
        }
    }
    
    
    struct SettingsPosition: View {
        
        var body: some View {
            //        ScrollView {
            Form{
                
                Section {
                    Text("Kommer Snart")
                    
                } header: {
                    Text("")
                }
                
            }
            .navigationTitle("Inställningar")
            //        }
            
        }
        
    }
    
    
}




struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingClass.SettingsAutoResa()
    }
}
