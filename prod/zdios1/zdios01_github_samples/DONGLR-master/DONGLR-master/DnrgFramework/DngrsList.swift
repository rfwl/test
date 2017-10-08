//
//  DngrsList.swift
//  Dongle
//
//  Created by vixi on 01.11.15.
//  Copyright © 2015 Anatoly Rosencrantz. All rights reserved.
//

import UIKit

open class DngrsList: NSObject {
    
    //MARK: computed merged lists
    var mergedSectionsNames: NSMutableArray {
        get{
            let list = NSMutableArray(array: presetSectionsNames)
            
            if !userCreated.isEmpty {
                list.insert("User Created", at: 0)
            }
            
            //фриквэнтли юзд
            if !frequentlyUsedStats.isEmpty {
                list.insert("Frequently used", at: 0)
            }
            
            return list
        }
    }
    var mergedList: NSMutableArray {
        get{
            //пресет
            let list = NSMutableArray(array: presetDngrs)
            
            //юзер креатед
            if !userCreated.isEmpty {
                list.insert(userCreated, at: 0)
                mergedSectionsNames.insert("User Created", at: 0)
            }
            
            //фриквэнтли юзд
            if !frequentlyUsedStats.isEmpty {
                let sorted = sortedFrequentlyUsed(frequentlyUsedStats)
                list.insert(sorted, at: 0)
                mergedSectionsNames.insert("Frequently used", at: 0)
            }
            
            return list
        }
    }
    
    //MARK: preset lists and lists whom we are updating manually
    var presetSectionsNames: [String] = []
    var presetDngrs: [[String]] = []
    var frequentlyUsedStats: [String:Int] = [:]
    var userCreated: [String] = []
    
    //MARK: vars and lets
    let numberOfFriquentlyUsedToShow = 9
    open weak var delegate: DngrsListDelegate?
    
    //MARK: - singleton stuff
    open static let sharedInstance = DngrsList()
    fileprivate override init() {
        super.init()
        
        loadDngrsFromFiles()
        NotificationCenter.default.addObserver(self,
                            selector: #selector(DngrsList.storeDidChange(_:)),
                            name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
                            object: NSUbiquitousKeyValueStore.default())
    }

    
    //MARK: - private for merged lists managing
    func loadDngrsFromFiles() {
        //базa cекций
        guard let plistFile2 = Bundle.main.path(forResource: "Sections", ofType: "plist") else {
            fatalError("Sections file not found")
        }
        presetSectionsNames =  NSArray(contentsOfFile: plistFile2) as! [String]
        
        //берем из файла базу донглов
        guard let plistFile = Bundle.main.path(forResource: "DonglesWithSections", ofType: "plist") else {
            fatalError("Dongles file not found")
        }
        presetDngrs =  NSArray(contentsOfFile: plistFile) as! [[String]]
        
        //часто используемые
        if let frequentlyUsedFromUserDefaults = UserDefaults.standard.value(forKey: "FrequentlyUsedStatistics")  {
            frequentlyUsedStats = frequentlyUsedFromUserDefaults as! [String : Int]
        }
        
        //берем юзер креатед
        writeFromKVStoSharedDefaults()
        userCreated = getListFromSharedDefaults()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func sortedFrequentlyUsed(_ frequentlyUsed: [String:Int]) -> [String] {
        var sortedArr: [String] = []         //сортируем по частоте использования
        for (k,_) in frequentlyUsed.sorted(by: {$0.1 > $1.1}) {
            sortedArr.append(k)
        }
        
        if sortedArr.count > numberOfFriquentlyUsedToShow {    //выбираем только N самых используемых
            return Array(sortedArr[0...numberOfFriquentlyUsedToShow])
        }
        
        return sortedArr
    }
    
    
    //MARK: public - reading stuff
    public func allDngrsList() -> [String] {
        var list = [String]()
        
        for section in mergedList{
            list.append(contentsOf: section as! [String])
        }
        
        return list
    }
    
    open func numberOfDngrsInSection(_ section: Int) -> Int {
        if mergedList.count >= section {
            return (mergedList[section] as AnyObject).count
        }
        
        //print("Unappropreate index of section \(section): greater than number of sections in dngrs list")
        return 0
    }
    
    open func numberOfSections() -> Int {
        return mergedList.count
    }
    
    open func getDngrFromMergedListAtIndexPath(_ indexPath: IndexPath) -> String {
        return (mergedList[(indexPath as NSIndexPath).section] as! Array)[(indexPath as NSIndexPath).item]
    }
    
    open func getDngrFromUserCreatedAtIndex(_ index: Int) -> String {
        return userCreated[index]
    }
    
    open func getSectionNameAtIndexPath(_ indexPath: IndexPath) -> String {
        return mergedSectionsNames[(indexPath as NSIndexPath).section] as! String
    }

    open func numberOfUserCreated() -> Int{
        return userCreated.count
    }
    
    
    //MARK: frequentlyUsed
    open func updateStatisticsForDngr(_ dngr: String){
        var currentRate = 0
        if let currentRateOpt = frequentlyUsedStats[dngr]{
            currentRate = currentRateOpt
        }
        frequentlyUsedStats.updateValue(currentRate + 1, forKey: dngr)
    }
    
    open func saveFrequentlyUsedStats() {
        UserDefaults.standard.setValue(frequentlyUsedStats, forKey: "FrequentlyUsedStatistics")
    }
    
    //MARK: userCreated and sync
    open func updateUserCreatedDngrAtIndex(_ index:Int?, toDngr dngr: String) {
        if index == nil {
            userCreated.append(dngr)
        }else if userCreated.count > index! {
            userCreated.remove(at: index!)
            userCreated.insert(dngr, at: index!)
        }else{
            userCreated.append(dngr)
        }
        
        putListToSharedDefaults(userCreated)
        writeToKVS(userCreated)
    }
    
    open func removeUserCreatedAtIndex(_ index: Int) {
        if userCreated.count > index {
            userCreated.remove(at: index)
        }
        
        putListToSharedDefaults(userCreated)
        writeToKVS(userCreated)
    }
    
    open func updateUserCreatedFromSharedDefaults() {
        userCreated = getListFromSharedDefaults()
    }
    
    
    //MARK: UPDATE STORES
    let keyForUserCreated = "UserCreatedDngrs"
    
    func storeDidChange(_ note: Notification) {
        writeFromKVStoSharedDefaults()
        delegate?.updateInterfaceOnUserCreatedDngrsSynced()
    }
    
    func writeFromKVStoSharedDefaults() {
        let kvs = NSUbiquitousKeyValueStore.default()
        kvs.synchronize()
        
        if let arr = kvs.array(forKey: keyForUserCreated) {
            let list = arr as! [String]
            userCreated = list
            putListToSharedDefaults(list)
        }
    }
    
    func writeToKVS(_ list: [String]) {
        let kvs = NSUbiquitousKeyValueStore.default()

        kvs.set(list, forKey: keyForUserCreated)
        kvs.synchronize()
    }
    
    //MARK: UserDefaults
    func putListToSharedDefaults(_ list: [String]) {
        UserDefaults(suiteName: "group.rosencrantz.donglerskeyboard")!.setValue(list, forKey: keyForUserCreated)
        UserDefaults(suiteName: "group.rosencrantz.donglerskeyboard")!.synchronize()
    }
    
    func getListFromSharedDefaults() -> [String] {
        if let userCreatedFromUserDefaults = UserDefaults(suiteName: "group.rosencrantz.donglerskeyboard")!.value(forKey: keyForUserCreated) {
            let list = userCreatedFromUserDefaults as! [String]
            return list
        }
        
        return []
    }
    
    
    //MARK: - Open Access and iCloud Access
    open func isOpenAccessGranted() -> Bool {
        let isGranted = UIPasteboard.general.isKind(of: UIPasteboard.self)
        return isGranted
    }
    
    open func isCloudLoggedIn() -> Bool {
        if let _ = FileManager.default.ubiquityIdentityToken {
            return true
        }
        
        return false
    }
}


//MARK: - Protocol
public protocol DngrsListDelegate: class {
    func updateInterfaceOnUserCreatedDngrsSynced()
}

