//
//  DubDubGrubApp.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/27/22.
//

import SwiftUI

@main
struct DubDubGrubApp: App {
    
    let locationManager = LocationManager()
    
    var body: some Scene {
        
        WindowGroup {
            DDGTabView().environmentObject(locationManager)
        }
    }
}
