//
//  ViewController.swift
//  kakeibo
//
//  Created by study on 2016/05/16.
//  Copyright © 2016年 study. All rights reserved.
//

import UIKit

class KakeiboViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dateTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var toolBar: UIToolbar!
    var datepicker: UIDatePicker!
    var kakei:Kakeibo! = nil
    var cat:String!
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (kakei == nil){
            return 0
        }else{
            return kakei.categories.count
        }
    }
    
    //セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        let str = kakei.categories[indexPath.row]
        cell.textLabel?.text = str
        cell.detailTextLabel?.text = String(kakei.moneys[str]!)
        return cell
    }
    
    //セルがタップされた
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath)
    {
        cat = kakei.categories[indexPath.row]
        performSegueWithIdentifier("toKakeiboSubViewController",sender: nil)
    }
    
    //遷移の準備（値の受け渡し）
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier! == "toKakeiboSubViewController") {
            let subVC: KakeiboSubViewController = (segue.destinationViewController as? KakeiboSubViewController)!
            subVC.kakei = kakei
            subVC.cat = cat
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datepicker = UIDatePicker()
        dateTextfield.inputView = datepicker
        datepicker.addTarget(self, action: #selector(KakeiboViewController.changedDateEvent(_:)), forControlEvents: UIControlEvents.ValueChanged)
        datepicker.locale = NSLocale(localeIdentifier: "ja_JP")
        datepicker.datePickerMode = UIDatePickerMode.Date
        
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.blueColor()
        toolBar.backgroundColor = UIColor.whiteColor()
        
        let toolBarBtnDone = UIBarButtonItem(title: "完了", style: .Bordered, target: self, action: #selector(KakeiboViewController.tappedToolBarBtn(_:)))
        let toolBarBtnToday = UIBarButtonItem(title: "今日", style: .Bordered, target: self, action: #selector(KakeiboViewController.tappedToolBarBtnToday(_:)))
        toolBarBtnDone.tag = 1
        toolBar.items = [toolBarBtnDone, toolBarBtnToday]
        
        dateTextfield.inputAccessoryView = toolBar
        
        dateTextfield.text = kakei?.date
        //kakei = Kakeibo(date: dateToString(NSDate()))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //"完了"のボタンが押された
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        dateTextfield.resignFirstResponder()
        kakei = Kakeibo(date: dateToString(datepicker.date))
        tableView.reloadData()
    }
    
    //"今日"のボタンが押された
    func tappedToolBarBtnToday(sender: UIBarButtonItem) {
        datepicker.date = NSDate()
        changedDateEvent(datepicker)
    }
    
    //日付が変更された
    func changedDateEvent(sender: UIDatePicker){
        dateTextfield.text = dateToString(datepicker.date)
    }
    
    
    func dateToString(date:NSDate) ->String {
        let date_formatter: NSDateFormatter = NSDateFormatter();
        date_formatter.locale = NSLocale(localeIdentifier: "ja");
        
        let weekdays:Array  = ["", "日", "月", "火", "水", "木", "金", "土"]
        let calendar = NSCalendar.currentCalendar();
        let comps = calendar.components([.Year, .Month, .Day, .Weekday], fromDate: date);
        date_formatter.dateFormat = "yyyy年MM月dd日（\(weekdays[comps.weekday]))"
        return date_formatter.stringFromDate(date)
    }
}

