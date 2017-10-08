//
//  KeyboardViewController.swift
//  DongleKeyboard
//
//  Created by vixi on 13.10.15.
//  Copyright © 2015 Anatoly Rosencrantz. All rights reserved.
//

import UIKit
import DnrgFramework

class KeyboardViewController: UIInputViewController {
    // MARK: outlets, lets and vars
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var controlsView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    var dngrsList: DngrsList?

    func keyboardWillChange(notification: NSNotification) {
        guard let keyboardRect = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
            fatalError("Failed to read notification")
        }
        heightConstraint.constant = keyboardRect.height
        self.view.setNeedsLayout()
    }
    
    // MARK: lifetime methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(KeyboardViewController.keyboardWillChange(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        
        if #available(iOSApplicationExtension 10.0, *) {
            nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: UIControlEvents.allTouchEvents)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        shadowForControlsView()

        dngrsList = DngrsList.sharedInstance
        
        //updating UserCreated dngrs manually from SharedDefaults (shared with container app)
        //else will update automatically by iCloud push notifications
        if (dngrsList?.isCloudLoggedIn() == false) {
            dngrsList?.updateUserCreatedFromSharedDefaults()
        }
        
        dngrsList?.delegate = self
        collectionView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //сохраняем в юзердефолтс
        dngrsList?.saveFrequentlyUsedStats()
    }
    
    
    // MARK: UI methods
    @IBAction override func advanceToNextInputMode() {
        super.advanceToNextInputMode()
    }
    
    @IBAction func spaceButton() {
        textDocumentProxy.insertText(" ")
    }
    
    @IBAction func enterButton() {
        textDocumentProxy.insertText("\n")
    }
    
    func shadowForControlsView() {
        guard let shadowRect = controlsView?.bounds else { return }
        
        let shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: CGFloat(0.0))
        
        controlsView.layer.masksToBounds = false
        controlsView.layer.shadowColor = UIColor.black.cgColor
        controlsView.layer.shadowOffset = CGSize(width: 0, height: 5.0);
        controlsView.layer.shadowOpacity = 1.0
        controlsView.layer.shadowPath = shadowPath.cgPath
    }
   
    
    // MARK: my methods
    @IBAction func deleteDongleOrSymbol() {
        guard let preInput = textDocumentProxy.documentContextBeforeInput else {
            textDocumentProxy.deleteBackward()
            return
        }
        
        if !textDocumentProxy.hasText {
            return
        }
        
        for dngr in dngrsList!.allDngrsList() {
            if succeededToFindAndDeleteDongle(dngr, inText: preInput) {
                return
            }
        }
        
        textDocumentProxy.deleteBackward()     //если не нашли - убираем один символ
    }

    func succeededToFindAndDeleteDongle(_ dongle: String, inText preInput: String) -> Bool{
        if preInput.characters.count<dongle.characters.count{  //если донгл длиннее, можно не проверять
            return false
        }
        
        if preInput.range(of: dongle, options: .backwards)?.upperBound == preInput.endIndex{
            for _ in 1...dongle.characters.count {
                textDocumentProxy.deleteBackward()
            }
            return true
        }

        return false
    }
}


// MARK: - data source
extension KeyboardViewController: UICollectionViewDataSource    {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dngrsList?.numberOfDngrsInSection(section) ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dngrsList?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyCell", for: indexPath) as? KeyCollectionViewCell else {
            fatalError("No cell with KeyCell found")
        }
        
        cell.dongleText = dngrsList?.getDngrFromMergedListAtIndexPath(indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "StartSectionView", for: indexPath) as? HeaderCollectionReusableView else {
            fatalError("No view StartSectionView found")
        }

        supView.sectionLabel.text = dngrsList?.getSectionNameAtIndexPath(indexPath)
        supView.sectionLabel.sizeToFit()
        supView.rotateSectionLabel()
        
        return supView
    }
}


// MARK: - collection view delegate
extension KeyboardViewController: UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? KeyCollectionViewCell else {
            fatalError("No cell for item found")
        }
        
        cell.flush()
        
        //печатаем куда надо
        textDocumentProxy.insertText((cell.dongleText ?? "") + " ")

        //обновляем статистику
        dngrsList?.updateStatisticsForDngr(cell.dongleText ?? "")
    }
}

// MARK: - dngrs list delegate
extension KeyboardViewController: DngrsListDelegate {
    func updateInterfaceOnUserCreatedDngrsSynced() {
        collectionView.reloadSections(IndexSet(integersIn: 0...1 ) )
    }
}
