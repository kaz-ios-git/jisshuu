//
//  ViewController.swift
//  myNotification
//
//  Created by study on 2016/05/05.
//  Copyright © 2016年 study. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tmp: weeklyNotification!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func testButton(sender: AnyObject) {
        tmp = weeklyNotification(date: CreateWeeklyNSDate(Weekdays.Fri.rawValue, hour: 0, minute: 0, second: 0), body: "hello", action_name: "open")
        tmp.regist()
    }
    
    @IBAction func testButton2(sender: AnyObject) {
        print(UIApplication.sharedApplication().scheduledLocalNotifications!)
    }
    
    @IBAction func tesuButton3(sender: AnyObject) {
        tmp?.delete()
    }
    
    @IBAction func testButton4(sender: AnyObject) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
}

