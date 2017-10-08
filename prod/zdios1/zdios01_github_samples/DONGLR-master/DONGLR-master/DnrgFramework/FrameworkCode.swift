//
//  FrameworkCode.swift
//  Dongle
//
//  Created by vixi on 27.10.15.
//  Copyright © 2015 Anatoly Rosencrantz. All rights reserved.
//

import Foundation
import CloudKit

//CLOUD KIT
let cloudRecordType: String = "DngrsCreatedByUser"
let cloudRecordName: String = "userCreatedDngrsList"

func getDngrsFromCloud() {
    var list: [String] = []
    
    let query = CKQuery(recordType: cloudRecordType, predicate: NSPredicate(value: true))
    
    let operation = CKQueryOperation(query: query)
    
    operation.recordFetchedBlock = { (record) in
        list = record["list"] as! [String]
    }
    
    operation.queryCompletionBlock = { (cursor, error) in
        if error == nil {
            print("CLOUD DOWNLOADED SUCCESSFULLY")
            print(list)
        } else {
            print("CLOUD ERROR WHILE DOWNLOADING: \(error)")
        }
    }
    
    CKContainer.default().publicCloudDatabase.add(operation)
}

func putDngrsToCloud(_ dngrs:[String]) {
    
    CKContainer.default().accountStatus { (status, error) in
        guard error == nil else {
            print("CLOUD ERROR WHILE CHECKING SIGN-IN: \(error)")
            return
        }
    }
    
    let recordID = CKRecordID.init(recordName: cloudRecordName)
    let cloudRecord = CKRecord(recordType: cloudRecordType, recordID: recordID)
    cloudRecord["list"] = dngrs as CKRecordValue?
    
    let transaction = CKModifyRecordsOperation(recordsToSave: [cloudRecord], recordIDsToDelete: [])
    transaction.isAtomic = true
    transaction.savePolicy = .allKeys
    transaction.database = CKContainer.default().publicCloudDatabase
    transaction.modifyRecordsCompletionBlock = { (saveRecs,deleteRecs, error) -> Void in
        if error == nil {
            print("CLOUD UPDATED SUCCESSFULLY")
        } else {
            print("CLOUD ERROR WHILE UPLOADING: \(error)")
        }
    }
    
    transaction.start()
}


// CLOUD KIT WITH DELEGATE?
protocol CloudControllerDelegate {
    func dngrAdded(_ dngr:String, index: Int)
    func dngrUpdated(_ dngr:String, index: Int)
}

class CloudController {
    let db: CKDatabase
    let delegate: CloudControllerDelegate
    
    init(delegate: CloudControllerDelegate) {
        self.delegate = delegate
        db = CKContainer.default().publicCloudDatabase
    }
        
}
