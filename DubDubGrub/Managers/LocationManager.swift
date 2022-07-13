//
//  LocationManager.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/28/22.
//

import Foundation

final class LocationManager: ObservableObject {
    
    @Published var locations: [DDGLocation] = []
    
    var selectedLocation: DDGLocation?
}
