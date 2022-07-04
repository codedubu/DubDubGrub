//
//  CloudKitManager.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/28/22.
//

import CloudKit

final class CloudKitManager {
    
    static let shared = CloudKitManager()
    
    private init() {}
    
    var userRecord: CKRecord?
    
    func getUserRecord() {
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                self.userRecord = userRecord
            }
        }
    }
    
    func getLocations(completion: @escaping (Result<[DDGLocation], Error>) -> Void) {
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
    
    func batchSave(records: [CKRecord], completion: @escaping (Result<[CKRecord], Error>) -> Void) {
        
        let operation = CKModifyRecordsOperation(recordsToSave: records)
        operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
            guard let savedRecords = savedRecords, error == nil else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(savedRecords))
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func fetchRecord(with id: CKRecord.ID, completion: @escaping (Result<CKRecord, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: id) { record, error in
            guard let record = record, error == nil else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(record))
        }
    }
}


//            var locations: [DDGLocation] = []
//
//            for record in records {
//                let location = DDGLocation(record: record)
//                locations.append(location)
//            }
