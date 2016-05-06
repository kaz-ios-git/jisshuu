//
//  Notification.swift
//  myNotification
//
//  Created by study on 2016/05/05.
//  Copyright © 2016年 study. All rights reserved.
//

import UIKit

enum Weekdays : Int{
    case Thu = 0
    case Fri
    case Sat
    case Sun
    case Mon
    case Tue
    case Wed
}

class Notification{
    private var noti :UILocalNotification!
    private var ID : NSDate!
    
    init(date :NSDate, body :String, action_name: String = "アプリを開く"){
        noti = UILocalNotification()
        noti.fireDate = date
        noti.timeZone = NSTimeZone.systemTimeZone()
        noti.alertBody = body
        noti.alertAction = action_name
        noti.soundName = UILocalNotificationDefaultSoundName
        noti.applicationIconBadgeNumber = 1
        ID = NSDate()
        noti.userInfo = ["NotiID" : ID]
    }
    
    func regist(){
         UIApplication.sharedApplication().scheduleLocalNotification(noti)
    }
    
    func delete(){
        for notice in UIApplication.sharedApplication().scheduledLocalNotifications!{
            let tmp = notice.userInfo!["NotiID"]! as! NSDate
            if tmp == ID{
                UIApplication.sharedApplication().cancelLocalNotification(notice)
            }
        }
    }
    
    func getID()->NSDate{
        return ID
    }
    
    
}

class dailyNotification : Notification{
    override init(date :NSDate, body :String, action_name: String = "アプリを開く"){
        super.init(date: date, body: body, action_name: action_name)
        noti.repeatInterval = NSCalendarUnit.Day
    }
}

class monthlyNotification : Notification{
    override init(date :NSDate, body :String, action_name: String = "アプリを開く"){
        super.init(date: date, body: body, action_name: action_name)
        noti.repeatInterval = NSCalendarUnit.Month
    }
}

class weeklyNotification : Notification{
    override init(date :NSDate, body :String, action_name: String = "アプリを開く"){
        super.init(date: date, body: body, action_name: action_name)
        noti.repeatInterval = NSCalendarUnit.WeekOfYear
    }
}

public func deleteNotification(ID : NSDate){
    for notice in UIApplication.sharedApplication().scheduledLocalNotifications!{
        let tmp = notice.userInfo!["NotiID"]! as! NSDate
        if tmp == ID{
            UIApplication.sharedApplication().cancelLocalNotification(notice)
        }
    }
}

public func CreateNSDate(year year: Int = 1970, month: Int = 1, day : Int = 1, hour: Int = 0, minute :Int = 0, second : Int = 0) -> NSDate{
    let calender = NSCalendar(identifier: NSCalendarIdentifierGregorian)
    return (calender!.dateWithEra(1, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: 0))!
}


public func CreateWeeklyNSDate(Weekday: Int, hour: Int = 0, minute :Int = 0, second : Int = 0) -> NSDate{
    let calender = NSCalendar(identifier: NSCalendarIdentifierGregorian)
    return (calender!.dateWithEra(1, year: 1970, month: 1, day: 1 + Weekday, hour: hour, minute: minute, second: second, nanosecond: 0))!
}

