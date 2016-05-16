//
//  ViewController.swift
//  kakeibo
//
//  Created by study on 2016/05/16.
//  Copyright © 2016年 study. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTextfield: UITextField!
    var toolBar: UIToolbar!
    var datepicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datepicker = UIDatePicker()
        dateTextfield.inputView = datepicker
        datepicker.addTarget(self, action: #selector(ViewController.changedDateEvent(_:)), forControlEvents: UIControlEvents.ValueChanged)
        datepicker.locale = NSLocale(localeIdentifier: "ja_JP")
        datepicker.datePickerMode = UIDatePickerMode.Date
        
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.blueColor()
        toolBar.backgroundColor = UIColor.whiteColor()
        
        let toolBarBtnDone = UIBarButtonItem(title: "完了", style: .Bordered, target: self, action: #selector(ViewController.tappedToolBarBtn(_:)))
        let toolBarBtnToday = UIBarButtonItem(title: "今日", style: .Bordered, target: self, action: #selector(ViewController.tappedToolBarBtnToday(_:)))
        toolBarBtnDone.tag = 1
        toolBar.items = [toolBarBtnDone, toolBarBtnToday]
        
        dateTextfield.inputAccessoryView = toolBar
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        dateTextfield.resignFirstResponder()
    }
    
    func tappedToolBarBtnToday(sender: UIBarButtonItem) {
        datepicker.date = NSDate()
        changedDateEvent(datepicker)
    }
    
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

