//
//  UIImage+Ext.swift
//  DubDubGrub
//
//  Created by River McCaine on 7/3/22.
//

import UIKit
import CloudKit

extension UIImage {
    
    func convertToCKAsset() -> CKAsset? {
        
        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            // Get our app's base document directoryurl
            print("Document Directory URL came back nil.")
            return nil
        }
        
        let fileURL = urlPath.appendingPathComponent("selectedAvatarImage")
        // Append some unique identiifier for our profile image
        guard let imageData = jpegData(compressionQuality: 0.25) else { return nil }
        // Write the image data to the location the address points to
        do {
            try imageData.write(to: fileURL)
            // Create our CKAsset with that fileURL
            return CKAsset(fileURL: fileURL)
        } catch {
            return nil
        }
    }
}
