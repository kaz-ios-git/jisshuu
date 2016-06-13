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
    @IBOutlet var navibar: UINavigationBar!
    @IBOutlet var year: UILabel!
    @IBOutlet var month: UILabel!
    @IBOutlet var week: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navibar.topItem?.title = kakei.date + ":" + cat
        year.text = String(kakei.sumby(kakei.separate("年"), genre: cat))
        month.text = String(kakei.sumby(kakei.separate("月"), genre: cat))
        week.text = String(kakei.sumbyweek(cat))
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