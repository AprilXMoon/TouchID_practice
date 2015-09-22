//
//  ViewController.swift
//  TouchID_Demo_swift
//
//  Created by April Lee on 2015/9/21.
//  Copyright © 2015年 april. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func authenticateButtonTapped(sender: UIButton) {
        
        let context = LAContext()
        var error :NSError?
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error)
        {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Are you the deveice owner?", reply: { (success: Bool, error: NSError?) -> Void in
                
                if success
                {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let alert = UIAlertView(title: "Success", message:"You are the device owner!" , delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let alert = UIAlertView(title:"Error", message: "You are not the device owner!", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    })
                }
                
                
                if error != nil
                {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let alert = UIAlertView(title: "Error", message: "There was a problem verifying your identify", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    })
                }
            })
        }
        
    }


}

