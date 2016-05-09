//
//  ViewController.swift
//  myNotification
//
//  Created by study on 2016/05/05.
//  Copyright © 2016年 study. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tmp: Notification!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var mylabel: UILabel!
    @IBOutlet weak var Lyear: UITextField!
    @IBOutlet weak var Lmonth: UITextField!
    @IBOutlet weak var Lday: UITextField!
    @IBOutlet weak var Lhour: UITextField!
    @IBOutlet weak var Lminute: UITextField!
    @IBOutlet weak var Lsecond: UITextField!
    
    @IBAction func mytapscreen(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func testButton(sender: AnyObject) {
        tmp = Notification(date: CreateNSDate(year: Int(Lyear.text!)!, month: Int(Lmonth.text!)!, day: Int(Lday.text!)!, hour: Int(Lhour.text!)!, minute: Int(Lminute.text!)!, second: Int(Lsecond.text!)!), body: "hello", action_name: "Open")
        tmp.regist()
       
    }
    
    @IBAction func testButton2(sender: AnyObject) {
        mylabel.text = UIApplication.sharedApplication().scheduledLocalNotifications?.description
        mylabel.numberOfLines = 0
        mylabel.sizeToFit()
        print(UIApplication.sharedApplication().scheduledLocalNotifications!)
    }
    
    @IBAction func tesuButton3(sender: AnyObject) {
        tmp?.delete()
    }
    
    @IBAction func testButton4(sender: AnyObject) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
}

