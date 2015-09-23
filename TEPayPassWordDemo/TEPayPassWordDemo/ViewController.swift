//
//  ViewController.swift
//  TEPayPassWordDemo
//
//  Created by offcn on 15/9/18.
//  Copyright (c) 2015年 Terry. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBAction func showPassWordClick(sender: UIButton) {
        TEPayPassWordView.sharedInsstance.showPassWordViewInView({(password:String)in
            var result:Bool = password == "123456" ? true:false
            var dic:NSDictionary = ["validateResult":(result)]
            
            NSNotificationCenter.defaultCenter().postNotificationName(KNotification_ValidatePassWord, object: nil, userInfo: dic as [NSObject : AnyObject])
        
        })
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

