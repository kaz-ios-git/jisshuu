//
//  Kakeibo.swift
//  kakeibo
//
//  Created by study on 2016/05/16.
//  Copyright © 2016年 study. All rights reserved.
//

import UIKit

class Kakeibo {
    let categories_init:[String] = ["合計","収入","食費","家賃","ガス代","水道代","電気代","通信費","衣料費","交際費","その他"]
    var categories:[String] = ["合計"]
    var moneys: [String: Int] = [:]
    var income:Set<String> = ["食費","家賃","ガス代","水道代","電気代","通信費","衣料費","交際費","その他"]
    var spending:Set<String> = ["収入"]
    var date:String!
    
    
    init(date:String){
        self.date = date
        load_config()
        for tmp in categories_init{
            if (!categories.contains(tmp)){
                categories.append(tmp)
            }
        }
        init_cats()
        load_book()
    }
    
    deinit{
        save_book()
        print("deinit")
    }
    
    func init_cats(){
        for keys in categories{
            if (moneys[keys] == nil){
                moneys[keys] = 0
            }
        }
    }
    
    func save_book(){
        moneys["合計"] = sum()
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(moneys, forKey: date)
    }
    
    func load_book(){
        let ud = NSUserDefaults.standardUserDefaults()
        let mny = ud.dictionaryForKey(date) as? [String:Int]
        if mny != nil{
            moneys = mny!
        }
    }
    
    func save_config(){
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(categories, forKey: "Kakeibo_config")
    }
    
    func load_config(){
        let ud = NSUserDefaults.standardUserDefaults()
        let cfg = ud.arrayForKey("Kakeibo_config") as? Array<String>
        if cfg != nil{
            categories = cfg!
        }
    }
    
    func sum()->Int{
        var total = 0
        for item in income{
            total -= moneys[item]!
        }
        for item in spending{
            total += moneys[item]!
        }
        return total
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