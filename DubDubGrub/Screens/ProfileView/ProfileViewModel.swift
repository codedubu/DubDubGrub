//
//  ProfileViewModel.swift
//  DubDubGrub
//
//  Created by River McCaine on 7/3/22.
//

import CloudKit

final class ProfileViewModel: ObservableObject {
    
    @Published var firstName            = ""
    @Published var lastName             = ""
    @Published var companyName          = ""
    @Published var bio                  = ""
    @Published var avatar               = PlaceholderImage.avatar
    @Published var isShowingPhotoPicker = false
    @Published var alertItem: AlertItem?
    
    
    func isValidProfile() -> Bool {
        
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count <= 100 else { return false }
        
        return true
    }
    
    func createProfile() {
        
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        let profileRecord = createProfileRecord()
        guard let userRecord = CloudKitManager.shared.userRecord else {
            //show an alert
            return
        }
        
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            switch result {
            case .success(_):
                // show alert
                break
            case .failure(_):
                // show alert
                break
            }
        }
    }
    
    
    func getProfile() {
        
        guard let userRecord = CloudKitManager.shared.userRecord else {
            // Get our UserRecord, this is what ties us to our profile
            //show an alert
            return
        }
        // Now that we have our UserRecord, grab the reference to the profile.
        guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else {
            //show alert
            return
        }
        let profileRecordID = profileReference.recordID
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case.success(let record):
                    let profile = DDGProfile(record: record)
                    firstName   = profile.firstName
                    lastName    = profile.lastName
                    companyName = profile.companyName
                    bio         = profile.bio
                    avatar      = profile.avatarImage
                    
                case.failure(_):
                    break
                }
            }
        }
    }
    
    private func createProfileRecord() -> CKRecord {
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[DDGProfile.kFirstName]    = firstName
        profileRecord[DDGProfile.kLastName]     = lastName
        profileRecord[DDGProfile.kCompanyName]  = companyName
        profileRecord[DDGProfile.kBio]          = bio
        profileRecord[DDGProfile.kAvatarAsset]  = avatar.convertToCKAsset()
        
        return profileRecord
    }
}
