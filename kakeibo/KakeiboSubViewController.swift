//
//  KakeiboSubViewController.swift
//  kakeibo
//
//  Created by study on 2016/05/22.
//  Copyright © 2016年 study. All rights reserved.
//

import UIKit

class KakeiboSubViewController: UIViewController{
    
    @IBOutlet var label1: UILabel!
    var kakei:Kakeibo! = nil
    var cat:String!
    @IBOutlet var mytextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapscreen(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func backButton(sender: AnyObject) {
        performSegueWithIdentifier("toKakeiboViewController",sender: nil)
    }
    
    @IBAction func endEdit(sender: AnyObject) {
        let str = mytextfield.text! as String
        let value = Int(str)
        if (value != nil) {
            kakei.moneys[cat] = value
        }else {
            kakei.moneys[cat] = 0
        }
        kakei.save_book()
        performSegueWithIdentifier("toKakeiboViewController",sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier! == "toKakeiboViewController") {
            let subVC: KakeiboViewController = (segue.destinationViewController as? KakeiboViewController)!
            subVC.kakei = kakei
        }
    }
}