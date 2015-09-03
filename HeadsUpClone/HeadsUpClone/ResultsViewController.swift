//
//  ResultsViewController.swift
//  HeadsUpClone
//
//  Created by Skibicki III, John (CHI-FCB) on 9/3/15.
//  Copyright (c) 2015 Skibicki III, John (CHI-FCB). All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    var total:NSNumber!
    var right:NSNumber!
    @IBOutlet var lblResults:UILabel!
    @IBAction func startOver(sender:AnyObject?) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let percent = CGFloat(right.floatValue / total.floatValue)
        let message = String(format: "You got %1.2f %% correct", percent)
        self.lblResults.text = message
    }
}
