//
//  Kakeibo.swift
//  kakeibo
//
//  Created by study on 2016/05/16.
//  Copyright © 2016年 study. All rights reserved.
//

import UIKit
import RealmSwift

class Book:Object{
    dynamic var date = ""
    dynamic var weekofyear:Int = 0
    let cells = List<Cell>()
    
    override static func primaryKey() -> String? {
        return "date"
    }
    
    override static func indexedProperties() -> [String] {
        return ["weekofyear"]
    }
    
}

class Cell:Object{
    dynamic var genre = ""
    dynamic var money = 0
}

class Kakeibo {
    let categories_init:[String] = ["合計","収入","出費"]
    var categories:[String] = ["合計"]
    var moneys: [String: Int] = [:]
    var income:Set<String> = ["出費"]
    var spending:Set<String> = ["収入"]
    var date:String!
    var weekofyear = 0
    
    
    init(date:String){
        self.date = date
        weekofyear = getTodayweekofyear(datefromstr(date))
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
        let realm = try! Realm()
        let book = Book()
        
        book.date = date
        book.weekofyear = weekofyear
        for mny in moneys {
            let cell = Cell()
            cell.genre = mny.0
            cell.money = mny.1
            book.cells.append(cell)
        }
        
        try! realm.write(){
            realm.add(book, update: true)
        }
        
        /*
        moneys["合計"] = sum()
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(moneys, forKey: date)
        */
    }
    
    func load_book(){
        let realm = try! Realm()
        let book = realm.objectForPrimaryKey(Book.self, key: date)
        
        if book != nil{
            for cell in (book?.cells)!{
                moneys[cell.genre] = cell.money
            }
        }
        /*
        let ud = NSUserDefaults.standardUserDefaults()
        let mny = ud.dictionaryForKey(date) as? [String:Int]
        if mny != nil{
            moneys = mny!
        }
         */
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
    
    func sumby(date:String, genre:String)->Int{
        var result = 0
        let realm = try! Realm()
        let predicate = NSPredicate(format: "date CONTAINS %@", date)
        let books = realm.objects(Book).filter(predicate)
        
        for book in books{
            for cell in book.cells{
                if(cell.genre == genre){
                    result += cell.money
                }
            }
        }
        return result
    }
    
    //
    func sumbyweek(genre:String, weekofyear:Int = -1)->Int{
        var result = 0
        var woy = weekofyear
        let realm = try! Realm()
        
        if woy == -1{
            woy = self.weekofyear
        }
        
        let predicate = NSPredicate(format: "weekofyear == %d", woy)
        let books = realm.objects(Book).filter(predicate)
        
        for book in books{
            for cell in book.cells{
                if(cell.genre == genre){
                    result += cell.money
                }
            }
        }
        return result
    }
    
    func searchByGenre(date:String, genre:String)->[String:Int]{
        let realm = try! Realm()
        var results:[String:Int] = [:]
        let predicate = NSPredicate(format: "date CONTAINS %@", date)
        let books = realm.objects(Book).filter(predicate)
        
        for book in books{
            for cell in book.cells{
                if(cell.genre == genre){
                    results[book.date] = cell.money
                }
            }
        }
        return results
    }
    
    func searchByGenreWeekly(genre:String, weekofyear:Int = -1)->[String:Int]{
        let realm = try! Realm()
        var results:[String:Int] = [:]
        var woy = weekofyear
        
        if woy == -1{
            woy = self.weekofyear
        }
        
        let predicate = NSPredicate(format: "weekofyear == %d", woy)
        let books = realm.objects(Book).filter(predicate)
        
        for book in books{
            for cell in book.cells{
                if(cell.genre == genre){
                    results[book.date] = cell.money
                }
            }
        }
        return results
    }
    /*
    func dateToString(date:NSDate) ->String {
        let date_formatter: NSDateFormatter = NSDateFormatter();
        date_formatter.locale = NSLocale(localeIdentifier: "ja");
        
        let weekdays:Array  = ["", "日", "月", "火", "水", "木", "金", "土"]
        let calendar = NSCalendar.currentCalendar();
        let comps = calendar.components([.Year, .Month, .Day, .Weekday], fromDate: date);
        date_formatter.dateFormat = "yyyy年MM月dd日（\(weekdays[comps.weekday]))"
        return date_formatter.stringFromDate(date)
    }
    */
    
    func datefromstr(str:String)->NSDate{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let tmp = str.componentsSeparatedByString("日")
        let date = formatter.dateFromString(tmp[0]+"日")
        return date!
    }
    
    func separate(str:String) ->String{
        let res = date.componentsSeparatedByString(str)
        return res[0] + str
    }
    
    func getTodayweekofyear(date:NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let comp : NSDateComponents = calendar.components(NSCalendarUnit.WeekOfYear,fromDate: date)
        return comp.weekOfYear
    }
}