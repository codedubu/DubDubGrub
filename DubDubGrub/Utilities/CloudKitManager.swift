//
//  CloudKitManager.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/28/22.
//

import CloudKit

struct CloudKitManager {
    
    static func getLocations(completion: @escaping (Result<[DDGLocation], Error>) -> Void) {
        let sortDescripter = NSSortDescriptor(key: DDGLocation.kName, ascending: true)
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        query.sortDescriptors = [sortDescripter]
        
              
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let records = records else { return }
            
            let locations = records.map { $0.convertToDDGLocation() }
            
            completion(.success(locations))
        }
    }
}


//            var locations: [DDGLocation] = []
//
//            for record in records {
//                let location = DDGLocation(record: record)
//                locations.append(location)
//            }
