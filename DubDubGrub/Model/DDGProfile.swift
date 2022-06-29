//
//  DDGProfile.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/28/22.
//

import CloudKit

struct DDGProfile {
        
    let ckRecordID: CKRecord.ID
    let firstName: String
    let lastName: String
    let bio: String
    let companyName: String
    let avatarAsset: CKAsset!
    var isCheckedIn: CKRecord.Reference? = nil

    init(record: CKRecord) {
        ckRecordID  = record.recordID
        firstName   = record[DDGProfile.kFirstName] as? String ?? "N/A"
        lastName    = record[DDGProfile.kLastName] as? String ?? "N/A"
        bio         = record[DDGProfile.kBio] as? String ?? "N/A"
        companyName = record[DDGProfile.kCompanyName] as? String ?? "N/A"
        avatarAsset = record[DDGProfile.kAvatarAsset] as? CKAsset
    }
}


// MARK: - Extensions

extension DDGProfile {
    
    static let kFirstName   = "firstName"
    static let kLastName    = "lastName"
    static let kBio         = "bio"
    static let kCompanyName = "companyName"
    static let kAvatarAsset = "avatarAsset"
    static let kIsCheckedIn = "isCheckedIn"
}

