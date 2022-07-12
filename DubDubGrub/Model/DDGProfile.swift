//
//  DDGProfile.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/28/22.
//

import CloudKit
import UIKit

struct DDGProfile: Identifiable {
        
    let id: CKRecord.ID
    let firstName: String
    let lastName: String
    let bio: String
    let companyName: String
    let avatarAsset: CKAsset!
    var isCheckedIn: CKRecord.Reference?

    init(record: CKRecord) {
        id          = record.recordID
        firstName   = record[DDGProfile.kFirstName] as? String ?? "N/A"
        lastName    = record[DDGProfile.kLastName] as? String ?? "N/A"
        bio         = record[DDGProfile.kBio] as? String ?? "N/A"
        companyName = record[DDGProfile.kCompanyName] as? String ?? "N/A"
        avatarAsset = record[DDGProfile.kAvatarAsset] as? CKAsset
        isCheckedIn = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference
    }
    
    var avatarImage: UIImage {
        guard let avatar = avatarAsset else { return PlaceholderImage.avatar }
        return avatar.convertToUIImage(in: .square)
    }
}


// MARK: - Extensions

extension DDGProfile {
    
    static let kFirstName           = "firstName"
    static let kLastName            = "lastName"
    static let kBio                 = "bio"
    static let kCompanyName         = "companyName"
    static let kAvatarAsset         = "avatarAsset"
    static let kIsCheckedIn         = "isCheckedIn"
    static let kIsCheckedInNilCheck = "isCheckedInNilCheck"
}

