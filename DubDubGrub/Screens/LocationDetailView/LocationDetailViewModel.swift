//
//  LocationDetailViewModel.swift
//  DubDubGrub
//
//  Created by River McCaine on 7/5/22.
//

import SwiftUI
import MapKit
import CloudKit

enum CheckInStatus { case checkedIn, checkedOut }

final class LocationDetailViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var isShowingProfileModal = false

    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    var location: DDGLocation
    
    init(location: DDGLocation) {
        self.location = location
    }
    
    func getDirectionsToLocation() {
        let placemark   = MKPlacemark(coordinate: location.location.coordinate)
        let mapItem     = MKMapItem(placemark: placemark)
        
        mapItem.name    = location.name
        
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking])
    }
    
    func callLocation() {
        guard let url = URL(string: "tel://\(location.phoneNumber)") else {
            alertItem = AlertContext.invalidPhoneNumber
            return
        }
        UIApplication.shared.open(url)
        //        if UIApplication.shared.canOpenURL(url) { } for iPads
    }
    
    func updateCheckInStatus(to checkInStatus: CheckInStatus) {
        // Retrieve the DDGProfile
        
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
            // show an alert
            return
        }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            switch result {
                
            case .success(let record):
                // create a reference to the location
                switch checkInStatus {
                case .checkedIn:
                    record[DDGProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                case .checkedOut:
                    record[DDGProfile.kIsCheckedIn] = nil
                }
                
                // Save the updated profile.
                CloudKitManager.shared.save(record: record) { result in
                    switch result {
                        
                    case .success(_):
                        // update our checkedInProfiles array
                        print("✅ Checked In/Out Sucessfully")
                    case .failure(_):
                        print("❌ Error saving record")
                    }
                }
                
            case .failure(_):
                print("❌ Error fetching record")
            }
        }
        
        // Create a reference to a location
        // Save the updated profile to CloudKit
    }
}
