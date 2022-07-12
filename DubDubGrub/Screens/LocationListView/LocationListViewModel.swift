//
//  LocationListViewModel.swift
//  DubDubGrub
//
//  Created by River McCaine on 7/12/22.
//

import Foundation
import CloudKit

final class LocationListViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [CKRecord.ID : [DDGProfile]] = [ : ]
    
    func getCheckedInProfilesDictionary() {
        CloudKitManager.shared.getCheckedInProfilesDictionary { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let checkedInProfiles):
                    self.checkedInProfiles = checkedInProfiles
                    print(checkedInProfiles)
                case .failure(_):
                    print("Error with rerieving dictionary.")
                }
            }
        }
    }
}
