//
//  DDGTabViewModel.swift
//  DubDubGrub
//
//  Created by River McCaine on 7/12/22.
//

import CoreLocation
import Foundation

final class DDGTabViewModel: NSObject, ObservableObject {
    
    @Published var isShowingOnboardingView = false
    @Published var alertItem: AlertItem?

    var deviceLocationManager: CLLocationManager?
    let kHasSeenOnBoardView = "hasSeenOnboardView"
    
    var hasSeenOnboardView: Bool {
        return UserDefaults.standard.bool(forKey: kHasSeenOnBoardView)
    }
    
    func runStartupChecks() {
        
        if !hasSeenOnboardView {
            isShowingOnboardingView = true
            UserDefaults.standard.setValue(true, forKey: kHasSeenOnBoardView)

        } else {
            checkIfLocationServicesIsEnabled()
        }
    }
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            deviceLocationManager = CLLocationManager()
            deviceLocationManager!.delegate = self
        } else {
            alertItem = AlertContext.locationDisabled
        }
    }
    
    private func checkLocationAuthorization() {
        guard let deviceLocationManager = deviceLocationManager else { return }
        
        switch deviceLocationManager.authorizationStatus {
            
        case .notDetermined:
            deviceLocationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertItem = AlertContext.locationRestricted
        case .denied:
            alertItem = AlertContext.locationDenied
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
}


// MARK: - Extensions
extension DDGTabViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
