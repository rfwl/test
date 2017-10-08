//
//  ConstructorViewController.swift
//  Dongle
//
//  Created by vixi on 26.10.15.
//  Copyright © 2015 Anatoly Rosencrantz. All rights reserved.
//

import UIKit
import DnrgFramework

class ConstructorViewController: UIViewController {
    // MARK: outlets and vars
    @IBOutlet var collectionView: UICollectionView?
    @IBOutlet var dngrTextField: UITextField?
    @IBOutlet var goButton: UIButton?
    @IBOutlet var jumpSectionButtons: [UIButton]!
    
    var arrayOfBodyParts: Array<Array<String>>? = []
    
    var dngrToChangeIndex: Int?
    let dngrList = DngrsList.sharedInstance
    
    var tap: UITapGestureRecognizer?
    
    // MARK: lifetime methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //берем из файла базу частей тел
        let plistFile = Bundle.main.path(forResource: "BodyParts", ofType: "plist")
        arrayOfBodyParts =  NSArray(contentsOfFile: plistFile!) as? Array<Array<String>>
        
        //загружаем в текстфилд днглр для редактирования
        if dngrToChangeIndex != nil {
            dngrTextField?.text = dngrList.getDngrFromUserCreatedAtIndex(dngrToChangeIndex!)
        }
        
        //жест чтоб прятать клавиатуру
        switchSaveButtonAvaliability()
        tap = UITapGestureRecognizer(target: self, action: #selector(ConstructorViewController.dismissKeyboard))
    }
    
    
    // MARK: my methods
    @IBAction func keyboardButtonPressed() {
        if dngrTextField!.isFirstResponder {
            textFieldShouldReturn(dngrTextField!)
        }else{
            dngrTextField?.becomeFirstResponder()
        }
    }
    
    @IBAction func goButtonPressed() {
        dngrList.updateUserCreatedDngrAtIndex(dngrToChangeIndex, toDngr: dngrTextField!.text!)
    }
    
    @IBAction func jumpToSection(_ sender: UIButton) {
        let numberOfSection = jumpSectionButtons.index(of: sender)
        let indexPath = IndexPath(row: 0, section: numberOfSection!)
        
        let headerRect = self.collectionView?.layoutAttributesForSupplementaryElement(ofKind: UICollectionElementKindSectionHeader, at: indexPath)?.frame
        let firstRowRect = self.collectionView?.layoutAttributesForItem(at: indexPath)?.frame
        let topRowPoint = CGPoint(x: 0, y: (firstRowRect?.origin.y)! - (headerRect?.height)!)
        
        self.collectionView?.setContentOffset(topRowPoint, animated: true)
    }
    
    func dismissKeyboard() {
        self.view.removeGestureRecognizer(tap!)
        dngrTextField?.resignFirstResponder()
    }
}


// MARK: - data source
extension ConstructorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BodyPartCell", for: indexPath) as! BodyPartCollectionViewCell
        
        cell.lable?.text = arrayOfBodyParts![(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (arrayOfBodyParts?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (arrayOfBodyParts?[section].count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! BodyPartCollectionViewHeader
        
        header.lableHeader?.text = jumpSectionButtons[(indexPath as NSIndexPath).section].titleLabel?.text
        
        return header
    }
    
    func switchSaveButtonAvaliability() {
        if (dngrTextField!.text?.isEmpty == true) {
            goButton?.isEnabled = false
        }else{
            goButton?.isEnabled = true
        }
    }
}


// MARK: - collection view delegate
extension ConstructorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BodyPartCollectionViewCell
        dngrTextField?.text?.append((cell.lable?.text)!)
        switchSaveButtonAvaliability()
    }
}


// MARK: - text field delegate
extension ConstructorViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.addGestureRecognizer(tap!)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.removeGestureRecognizer(tap!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        switchSaveButtonAvaliability()
        
        return true
    }
}
