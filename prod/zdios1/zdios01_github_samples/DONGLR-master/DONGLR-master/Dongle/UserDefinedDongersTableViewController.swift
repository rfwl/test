//
//  UserDefinedDongersTableViewController.swift
//  Dongle
//
//  Created by vixi on 27.10.15.
//  Copyright © 2015 Anatoly Rosencrantz. All rights reserved.
//

import UIKit
import DnrgFramework
import DZNEmptyDataSet

class UserDefinedDongersTableViewController: UITableViewController {
    // MARK: vars
    var dngrsList = DngrsList.sharedInstance
    @IBOutlet var leftButton: UIButton?
    @IBOutlet var rightButton: UIButton?
    
    //for stretchy header
    let headerHeight: CGFloat = 110.0
    var headerView: UIView!
    
    // MARK: lifetime methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dngrsList.delegate = self
        configureDZNEmptyData()
        
        //stratchy header
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: headerHeight, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.contentOffset = CGPoint(x: 0.0, y: -headerHeight)
        
        updateHeaderView()
    }
    
    override func viewDidLayoutSubviews() {
        if dngrsList.isOpenAccessGranted() == false {
            //тут ругаемся
            //требуем включить доступ
            //и пересылаем на исктрукцию как это сделать
            openLeft(leftButton!)
        }
    }
    
    
    // MARK: table view data source and delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dngrsList.numberOfUserCreated()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dngrCell", for: indexPath) as! UserDefinedDonglerTableViewCell

        cell.label?.text = dngrsList.getDngrFromUserCreatedAtIndex((indexPath as NSIndexPath).row)

        return cell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAct = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) -> Void in
            self.dngrsList.removeUserCreatedAtIndex((indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if tableView.numberOfRows(inSection: (indexPath as NSIndexPath).section) == 0 {
                tableView.reloadEmptyDataSet()
            }
        }
        let editAct = UITableViewRowAction(style: .normal, title: "Change") { (action, indexPath) -> Void in
            self.performSegue(withIdentifier: "EditSegue", sender: indexPath)
            self.tableView.isEditing = false
        }
        editAct.backgroundColor = UIColor.orange
        
        return [deleteAct, editAct]
    }

    // MARK: segues methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditSegue" {
            let dvc = segue.destination as! ConstructorViewController
            
            dvc.dngrToChangeIndex = ((sender as! IndexPath) as NSIndexPath).row
        }else if segue.identifier == "AddSegue" {
        }
    }
    
    @IBAction func unwindFromConstrutor(_ segue: UIStoryboardSegue){
        if let src = segue.source as? ConstructorViewController {
            tableView.reloadData()
            
            if let index = src.dngrToChangeIndex {
            tableView.scrollToRow(at: IndexPath(item: index, section: 0), at: UITableViewScrollPosition.bottom, animated: false)
            }else{
                if tableView.numberOfRows(inSection: 0) > 0 {
                    tableView.scrollToRow(at: IndexPath(item: tableView.numberOfRows(inSection: 0) - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: false)
                }
            }
        }
    }
    
    // MARK: MSDynamicsDrawerViewController
    @IBAction func openLeft(_ sender: UIButton) {
        let appdel = UIApplication.shared.delegate as! AppDelegate
        appdel.openLeft(sender)
    }
    
    @IBAction func openRight(_ sender: UIButton) {
        let appdel = UIApplication.shared.delegate as! AppDelegate
        appdel.openRight(sender)
    }
    
    
    //MARK: Stretchy header
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -headerHeight, width: tableView.bounds.width, height: headerHeight)
        
        if tableView.contentOffset.y < -headerHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}


//MARK: - dngrs list delegate
extension UserDefinedDongersTableViewController: DngrsListDelegate {
    func updateInterfaceOnUserCreatedDngrsSynced() {
        tableView.reloadData()
        tableView.reloadEmptyDataSet()
    }
}


//MARK: - DZNEmptyDataSet, background for empty state of tableView, cocoapods
extension UserDefinedDongersTableViewController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func configureDZNEmptyData() {
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self
        
        self.tableView.tableFooterView = UIView()
    }

    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = NSLocalizedString("Go, tap on compass to create your own dngrs! They will be avaliable on keyboard if Open Access is enabled.", comment: "empty tableView placeholder")
        
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0),
            NSForegroundColorAttributeName: UIColor.lightGray]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}
