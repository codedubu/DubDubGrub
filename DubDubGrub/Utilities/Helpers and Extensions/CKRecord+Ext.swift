//
//  CKRecord+Ext.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/28/22.
//

import Foundation
import CloudKit

extension CKRecord {
    
    func convertToDDGLocation() -> DDGLocation { DDGLocation(record: self) }
    func convertToDDGProfile() -> DDGProfile { DDGProfile(record: self) }
}
