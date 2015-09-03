//
//  DetailsTableViewController.swift
//  HeadsUpClone
//
//  Created by Skibicki III, John (CHI-FCB) on 9/3/15.
//  Copyright (c) 2015 Skibicki III, John (CHI-FCB). All rights reserved.
//

import UIKit
import Parse

class DetailsTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {
    var addNew:UIAlertController!
    var items = NSMutableArray(capacity: 0)
    let objName = "Detail"
    var parentObj:PFObject!
    
    override func viewDidLoad() {
        self.title = self.parentObj!["name"] as? String
        super.viewDidLoad()
        let addBtn = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("add:"))
        self.navigationItem.rightBarButtonItem = addBtn
        
        self.refresh()
    }
    
    func refresh() {
        let q = PFQuery(className: self.objName)
        q.whereKey("parent", equalTo: self.parentObj)
        //q!.fromLocalDatastore()
        q.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                self.items = NSMutableArray(array: objects!)
                self.tableView.reloadData()
            } else {
                println("Error getting objects")
                println(error?.description)
            }
            return
        }
    }
    
    func add(sender: AnyObject?) {
        self.addNew = UIAlertController(title: "Category", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        addNew.addTextFieldWithConfigurationHandler { (textfield) in
            textfield.placeholder = "Type Something Here"
        }
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (_) in
            self.addNew.dismissViewControllerAnimated(true, completion: nil)
        }
        addNew.addAction(cancel)
        let add = UIAlertAction(title: "Add", style: .Default) { (_) in
            let valueField = self.addNew.textFields![0] as! UITextField
            let value = valueField.text
            if(!value.isEmpty) {
                let newDetail = PFObject(className: self.objName);
                newDetail["name"] = value
                newDetail["parent"] = self.parentObj
                //let relation = self.parentObj!.relationForKey("Details")
                //relation.addObject(newDetail)
                newDetail.saveInBackgroundWithBlock({ (_) in
                    self.refresh()
                })
            }
        }
        addNew.addAction(add)
        self.presentViewController(self.addNew, animated: true, completion: nil)
    }
    
    
    //delegate methods
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("Detail", sender: nil)
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "defaultcell")
        let i = self.items.objectAtIndex(indexPath.row) as! PFObject
        cell.textLabel?.text = i["name"] as? String
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
}
