//
//  KakeiboBarChartViewController.swift
//  kakeibo
//
//  Created by study on 2016/06/26.
//  Copyright © 2016年 study. All rights reserved.
//

import UIKit
import Charts

class KakeiboBarChartViewController: UIViewController{
    
    @IBOutlet var navibar: UINavigationBar!
    @IBOutlet var barchart: BarChartView!
    var range:String! = nil
    var kakei:Kakeibo! = nil
    var cat:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setchart()
        navibar.topItem?.title = range + "の" + cat
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButton(sender: AnyObject) {
        performSegueWithIdentifier("toKakeiboSubViewControllerFromBarChart",sender: nil)
    }
    
    func setchart(){
        let dataPoints:Array<String>
        let values:Array<Int>
        var dataEntries: [BarChartDataEntry] = []
        var dics = kakei.searchByGenre(range, genre: cat)
        if range.containsString("週") == true{
            dics = kakei.searchByGenreWeekly(cat)
        }
        dataPoints = Array(dics.keys)
        values = Array(dics.values)
        
        barchart.drawBarShadowEnabled = false
        barchart.drawBordersEnabled = true
        barchart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        barchart.descriptionText = range + "の" + cat
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: Double(values[i]), xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "金額")
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        barchart.data = chartData
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier! == "toKakeiboSubViewControllerFromBarChart") {
            let subVC: KakeiboSubViewController = (segue.destinationViewController as? KakeiboSubViewController)!
            subVC.kakei = kakei
            subVC.cat = cat
        }
    }

    
}