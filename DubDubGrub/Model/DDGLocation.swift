//
//  DDGLocation.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/28/22.
//

import CloudKit
import UIKit



struct DDGLocation: Identifiable {
    
    let id: CKRecord.ID
    let name: String
    let description: String
    let address: String
    let phoneNumber: String
    let websiteURL: String
    let location: CLLocation
    let bannerAsset: CKAsset!
    let squareAsset: CKAsset!
    
    init(record: CKRecord) {
        id          = record.recordID
        name        = record[DDGLocation.kName] as? String ?? "N/A"
        description = record[DDGLocation.kDescription] as? String ?? "N/A"
        address     = record[DDGLocation.kAddress] as? String ?? "N/A"
        phoneNumber = record[DDGLocation.kPhoneNumber] as? String ?? "N/A"
        websiteURL  = record[DDGLocation.kWebsiteURL] as? String ?? "N/A"
        location    = record[DDGLocation.kLocation] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        bannerAsset = record[DDGLocation.kBannerAsset] as? CKAsset
        squareAsset = record[DDGLocation.kSquareAsset] as? CKAsset
    }
    
    var squareImage: UIImage {
        guard let asset = squareAsset else { return PlaceholderImage.square }
        return asset.convertToUIImage(in: .square)
    }
    
    var bannerImage: UIImage {
        guard let asset = bannerAsset else { return PlaceholderImage.banner }
        return asset.convertToUIImage(in: .banner)
    }
}
    // MARK: - Extensions
    
    extension DDGLocation {
        
        static let kName        = "name"
        static let kDescription = "description"
        static let kAddress     = "address"
        static let kPhoneNumber = "phoneNumber"
        static let kWebsiteURL  = "websiteURL"
        static let kLocation    = "location"
        static let kBannerAsset = "bannerAsset"
        static let kSquareAsset = "squareAsset"
    }
