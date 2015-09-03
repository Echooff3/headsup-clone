//
//  GamePlayViewController.swift
//  HeadsUpClone
//
//  Created by Skibicki III, John (CHI-FCB) on 9/3/15.
//  Copyright (c) 2015 Skibicki III, John (CHI-FCB). All rights reserved.
//

import UIKit
import Parse

class GamePlayViewController: UITableViewController {
    var items = NSMutableArray(capacity: 0)
    let objName = "Cat"
    var selectedObject:PFObject!
    override func viewDidLoad() {
        self.title = "Choose A category"
        
        let quitBtn = UIBarButtonItem(title: "Quit", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("quit:"))
        self.navigationItem.rightBarButtonItem = quitBtn
        
        refresh()
    }
    
    func quit(sender:AnyObject?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func refresh() {
        let q = PFQuery(className: self.objName)
        //q.fromLocalDatastore()
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
    //delegate methods
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedObject = self.items.objectAtIndex(indexPath.row) as? PFObject
        self.performSegueWithIdentifier("Ready", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "Ready") {
            var vc = segue.destinationViewController as? ReadyViewController
            vc?.selectedObject = self.selectedObject
        }
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
