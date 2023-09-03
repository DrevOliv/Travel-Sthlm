//
//  Environment Keys.swift
//  AutoResaMedIN
//
//  Created by Oliver Drevet on 2022-08-17.
//

import Foundation
import SwiftUI

struct LocationState: EnvironmentKey {
    static var defaultValue: Int32 = 7
}




extension EnvironmentValues {
    var locationstate: Int32 {
        get { self[LocationState.self] }
        set { self[LocationState.self] = newValue }
    }
}




