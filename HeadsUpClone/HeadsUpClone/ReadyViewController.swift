//
//  ReadyViewController.swift
//  HeadsUpClone
//
//  Created by Skibicki III, John (CHI-FCB) on 9/3/15.
//  Copyright (c) 2015 Skibicki III, John (CHI-FCB). All rights reserved.
//

import UIKit
import Parse

class ReadyViewController: UIViewController {
    var selectedObject:PFObject!
    var items = NSMutableArray(capacity: 0)
    override func viewDidLoad() {
    }
    override func viewDidAppear(animated: Bool) {
        //Get items
        let q = PFQuery(className: "Detail")
        q.whereKey("parent", equalTo: self.selectedObject)
        var tmp = q.findObjects()
        self.items = NSMutableArray(array: tmp!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            println("landscape")
            NSNotificationCenter.defaultCenter().removeObserver(self)
            self.performSegueWithIdentifier("Action", sender: nil)
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            println("Portrait")
        }
        
    }

    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "Action") {
            var vc = segue.destinationViewController as! ActionViewController
            var names = NSMutableArray(capacity: 0)
            for i in self.items {
                if let t = i as? PFObject {
                    names.addObject(t["name"] as! String)
                }
            }
            
            vc.selectedItems = names
        }
    }
    
    func shuffle(array: NSMutableArray) {
        let count = array.count
        for i in 0 ..< (count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            array.exchangeObjectAtIndex(i, withObjectAtIndex: j)
        }
    }
}
