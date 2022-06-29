//
//  DDGLocation.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/28/22.
//

import CloudKit



struct DDGLocation {
    
    static let kName        = "name"
    static let kDescription = "description"
    static let kAddress     = "address"
    static let kPhoneNumber = "phoneNumber"
    static let kWebsiteURL  = "websiteURL"
    static let kLocation    = "location"
    static let kBannerAsset = "bannerAsset"
    static let kSquareAsset = "squareAsset"

    
    let ckRecordID: CKRecord.ID
    let name: String
    let description: String
    let address: String
    let phoneNumber: String
    let websiteURL: String
    let location: CLLocation
    let bannerAsset: CKAsset!
    let squareAsset: CKAsset!

    init(record: CKRecord) {
        ckRecordID  = record.recordID
        name        = record[DDGLocation.kName] as? String ?? "N/A"
        description = record[DDGLocation.kDescription] as? String ?? "N/A"
        address     = record[DDGLocation.kAddress] as? String ?? "N/A"
        phoneNumber = record[DDGLocation.kPhoneNumber] as? String ?? "N/A"
        websiteURL  = record[DDGLocation.kWebsiteURL] as? String ?? "N/A"
        location    = record[DDGLocation.kLocation] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        bannerAsset = record[DDGLocation.kBannerAsset] as? CKAsset
        squareAsset = record[DDGLocation.kSquareAsset] as? CKAsset
    }

}
