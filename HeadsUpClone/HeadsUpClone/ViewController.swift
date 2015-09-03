//
//  ViewController.swift
//  HeadsUpClone
//
//  Created by Skibicki III, John (CHI-FCB) on 9/3/15.
//  Copyright (c) 2015 Skibicki III, John (CHI-FCB). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func playGame(sender: AnyObject?) {
        let viewController:UIViewController = UIStoryboard(name: "GamePlay", bundle: nil).instantiateViewControllerWithIdentifier("GameNav") as! UINavigationController
        self.presentViewController(viewController, animated: false, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

