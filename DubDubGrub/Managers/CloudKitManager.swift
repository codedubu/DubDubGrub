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
    var profileRecordID: CKRecord.ID?
    
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
                
                if let profileReference = userRecord["userProfile"] as? CKRecord.Reference {
                    self.profileRecordID = profileReference.recordID
                }
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
    
    func getCheckedInProfiles(for locationID: CKRecord.ID, completion: @escaping (Result<[DDGProfile], Error>) -> Void) {
        let reference   = CKRecord.Reference(recordID: locationID, action: .none)
        let predicate   = NSPredicate(format: "isCheckedIn == %@", reference)
        let query       = CKQuery(recordType: RecordType.profile, predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            guard let records = records, error == nil else {
                completion(.failure(error!))
                return
            }
            
            let profiles = records.map { $0.convertToDDGProfile() }
            completion(.success(profiles))
            
        }
    }
    
    func getCheckedInProfilesDictionary(completion: @escaping (Result<[CKRecord.ID : [DDGProfile]], Error>) -> Void) {
        let predicate   = NSPredicate(format: "isCheckedInNilCheck == 1")
        let query       = CKQuery(recordType: RecordType.profile, predicate: predicate)
        let operation   = CKQueryOperation(query: query)
        //        operation.desiredKeys = [DDGProfile.kIsCheckedIn, DDGProfile.kAvatarAsset]
        
        var checkedInProfiles: [CKRecord.ID : [DDGProfile]] = [ : ]
        
        operation.recordFetchedBlock = { record in
            // Build our dictionary
            let profile = DDGProfile(record: record)
            
            guard let locationReference = profile.isCheckedIn else { return }
            
            checkedInProfiles[locationReference.recordID, default: []].append(profile)
            // Chipotle : [Riv, Div]
            // Mezcals  : [Brokk]
        }
        
        operation.queryCompletionBlock = { cursor, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            // handle cursor later
            completion(.success(checkedInProfiles))
        }
        CKContainer.default().publicCloudDatabase.add(operation)
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
    
    func save(record: CKRecord, completion: @escaping (Result<CKRecord, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.save(record) { record, error in
            guard let record = record, error == nil else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(record))
        }
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
