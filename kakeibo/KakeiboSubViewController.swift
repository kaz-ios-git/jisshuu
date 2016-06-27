//
//  KakeiboSubViewController.swift
//  kakeibo
//
//  Created by study on 2016/05/22.
//  Copyright © 2016年 study. All rights reserved.
//

import UIKit

class KakeiboSubViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var label1: UILabel!
    var kakei:Kakeibo! = nil
    var cat:String!
    let range  = ["日","年","月","週"]
    var ran:String!=nil
    @IBOutlet var mytextfield: UITextField!
    @IBOutlet var navibar: UINavigationBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navibar.topItem?.title! = kakei.date + ":" + cat
        
        if(cat == "合計"){
            mytextfield.enabled = false
            label.enabled = false
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return range.count
    }
    
    //セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        let str:String
        let value:String
        
        if range[indexPath.row] == "日"{
            let label = tableView.viewWithTag(3) as! UILabel
            label.text = ""
        }
        
        if range[indexPath.row] == "週"{
            value = "¥" + String(kakei.sumbyweek(cat))
            str = "この週"
        }else{
            value = "¥" + String(kakei.sumby(kakei.separate(range[indexPath.row]), genre: cat))
            str = kakei.separate(range[indexPath.row])
        }
        
        let label_range = tableView.viewWithTag(1) as! UILabel
        label_range.text = str
        let label_value = tableView.viewWithTag(2) as! UILabel
        label_value.text = value
        
        return cell
    }
    
    //セルがタップされた
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath)
    {
        if range[indexPath.row] != "日"{
            if range[indexPath.row] == "週" {
                ran = kakei.separate("年") + "第" + String(kakei.weekofyear) + "週"
            }else{
                ran = kakei.separate(range[indexPath.row])
            }
            performSegueWithIdentifier("toBarChartViewController",sender: nil)
        }
    }
    
    //遷移の準備（値の受け渡し）
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier! == "toBarChartViewController") {
            let subVC:KakeiboBarChartViewController = (segue.destinationViewController as? KakeiboBarChartViewController)!
            subVC.kakei = kakei
            subVC.cat = cat
            subVC.range = ran
        }
        if (segue.identifier! == "toKakeiboViewController") {
            let subVC: KakeiboViewController = (segue.destinationViewController as? KakeiboViewController)!
            subVC.kakei = kakei
        }
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
}