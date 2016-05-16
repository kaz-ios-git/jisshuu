//
//  Kakeibo.swift
//  kakeibo
//
//  Created by study on 2016/05/16.
//  Copyright © 2016年 study. All rights reserved.
//

import Foundation

class Kakeibo {
    var categories:[String] = ["食費","家賃","ガス代","水道代","電気代","通信費","衣料費","交際費","その他"]
    var moneys: [String: Int] = [:]
    
    
    init(){
        init_cats()
    }
    
    deinit{
        
    }
    
    func init_cats(){
        for keys in categories{
            if (moneys[keys] == nil){
                moneys[keys] = 0
            }
        }
    }
    
    func save_book(){
        
    }
    
    func load_book(){
        
    }
    
    func save_config(){
        
    }
    
    func load_config(){
        
    }
}