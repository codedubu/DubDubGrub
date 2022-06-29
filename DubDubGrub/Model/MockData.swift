//
//  MockData.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/28/22.
//

import CloudKit

struct MockData {
    
    static var location: CKRecord {
        let record = CKRecord(recordType: RecordType.location)
        
        record.setValuesForKeys([
            DDGLocation.kName           : "River's Bar and Grill",
            DDGLocation.kAddress        : "123 Duka Duka Road",
            DDGLocation.kDescription    : "This is a testing of a testing app. It tests the testing of tests that tests, testingly. Isn't that quite testifying?",
            DDGLocation.kLocation       : CLLocation(latitude: 37.331516, longitude: -121.891054),
            DDGLocation.kWebsiteURL     : "http://www.guadalajaraoakland.com/",
            DDGLocation.kPhoneNumber    : "510-926-0098"
        ])
        
        return record
    }
}


