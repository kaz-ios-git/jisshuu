//
//  Notification.swift
//  myNotification
//
//  Created by study on 2016/05/05.
//  Copyright © 2016年 study. All rights reserved.
//

import UIKit

public func RegistNotification (date :NSDate, body :String, action_name: String = "アプリを開く")-> NSDate{

    let noti = UILocalNotification()
    noti.fireDate = date
    noti.timeZone = NSTimeZone.systemTimeZone()
    noti.alertBody = body
    noti.alertAction = action_name
    noti.soundName = UILocalNotificationDefaultSoundName
    noti.applicationIconBadgeNumber = 1
    let key = NSDate()
    noti.userInfo = ["NotiID" : key]
    UIApplication.sharedApplication().scheduleLocalNotification(noti)
    
    return key
}

public func RegistNotificationDaily(date :NSDate, body :String, action_name: String = "アプリを開く")-> NSDate{
    let noti = UILocalNotification()
    noti.fireDate = date
    noti.timeZone = NSTimeZone.systemTimeZone()
    noti.alertBody = body
    noti.alertAction = action_name
    noti.soundName = UILocalNotificationDefaultSoundName
    noti.repeatInterval = NSCalendarUnit.Day
    noti.applicationIconBadgeNumber = 1
    let key = NSDate()
    noti.userInfo = ["NotiID" : key]
    UIApplication.sharedApplication().scheduleLocalNotification(noti)
    
    return key
}

public func DeleteNotification(key :NSDate){
    for noti in UIApplication.sharedApplication().scheduledLocalNotifications!{
        let tmp = noti.userInfo!["NotiID"]! as! NSDate
        if tmp == key{
             UIApplication.sharedApplication().cancelLocalNotification(noti)
        }
    }
}




public func CreateNSDate(year year: Int = 1970, month: Int = 1, day : Int = 1, hour: Int = 0, minute :Int = 0, second : Int = 0) -> NSDate{
    
    let calender = NSCalendar(identifier: NSCalendarIdentifierGregorian)
    return (calender!.dateWithEra(1, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: 0))!
    
}