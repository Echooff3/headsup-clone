//
//  ActionViewController.swift
//  HeadsUpClone
//
//  Created by Skibicki III, John (CHI-FCB) on 9/3/15.
//  Copyright (c) 2015 Skibicki III, John (CHI-FCB). All rights reserved.
//

import UIKit
import Parse
import CoreMotion

class ActionViewController: UIViewController {
    var selectedItems = NSMutableArray(capacity: 0)
    var selectedIndex = 0
    var numCorrect = 0
    var isProcessing:Bool = false
    let mm = CMMotionManager();
    
    @IBOutlet var txtClue:UILabel!
    override func viewDidLoad() {
        self.isProcessing = false
        self.txtClue.text = self.selectedItems.objectAtIndex(selectedIndex) as? String
        mm.accelerometerUpdateInterval = 0.1
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.selectedIndex = 0
        self.numCorrect = 0
        self.isProcessing = false
        self.txtClue.text = self.selectedItems.objectAtIndex(selectedIndex) as? String
        mm.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {
            [weak self] (data: CMAccelerometerData!, error: NSError!) in
            if (self?.isProcessing != nil || self?.isProcessing == true) {
                if data.acceleration.z == 0.0 {
                    self?.isProcessing = false
                }
                return
            }
            self?.isProcessing = true
            if(data.acceleration.z > 0.9) {
                self?.correct()
            } else if (data.acceleration.z < -0.9){
                self?.pass()
            }
            return
        })
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mm.stopAccelerometerUpdates()
    }
    
    func advance () {
        selectedIndex = selectedIndex + 1
        if(selectedIndex > (selectedItems.count - 1) || selectedIndex > 10) {
            selectedIndex = selectedIndex - 1
            self.performSegueWithIdentifier("Results", sender: self)
        } else {
            self.txtClue.text = self.selectedItems.objectAtIndex(selectedIndex) as? String
        }
        //isProcessing = false
    }
    
    func correct () {
        self.numCorrect = numCorrect + 1
        advance()
    }
    
    func pass () {
       advance()
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "Results") {
            var vc = segue.destinationViewController as! ResultsViewController
            vc.total = self.selectedIndex
            vc.right = self.numCorrect
        }
    }
    
}