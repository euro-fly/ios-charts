//
//  ChartViewController.swift
//  charts-test5
//
//  Created by Jacob on 2018/05/31.
//  Copyright © 2018 Jacob. All rights reserved.
//

import Foundation
import Charts
import UIKit

protocol GetChartData {
    func getChartData(with dataPoints: [String], values: [[String]])
    var xAxis: [String] {get set}
    var yAxis: [[String]] {get set}
}



@objc class ChartViewController: UIViewController, GetChartData {
    @IBOutlet weak var myLineChart: LineChart!
    var xAxis = [String]()
    var yAxis = [[String]]()
    
    @IBOutlet weak var myRotateButton: UIButton!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    var weightPanel: UILabel?
    var fatPanel: UILabel?
    
    @IBAction func rotate(_ sender: Any) {
        if UIDevice.current.orientation.isLandscape {
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
        else if UIDevice.current.orientation.isPortrait {
            let value = UIInterfaceOrientation.landscapeRight.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
    }
    
//    @IBOutlet weak var lineChart: LineChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(myLineChart)
        self.view.addSubview(buttonSet)
        self.view.addSubview(weightLabel)
        self.view.addSubview(fatLabel)
        populateChartData()
        lineChart()
    }

    
     //override func viewDidLayoutSubviews() {
        //super.viewDidLayoutSubviews()
        //RefreshChart()
    //}
    
    func RefreshChart() {
        myLineChart.removeLimitLine()
        lineChart()
        //self.view.setNeedsDisplay()
        //self.view.setNeedsLayout()
        //self.view.setNeedsUpdateConstraints()
    }
    
    @IBOutlet weak var buttonSet: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: Any) {
        switch buttonSet.selectedSegmentIndex {
        case 0:
            populateChartDataThree()
            RefreshChart()
            break
        case 1:
            populateChartData()
            RefreshChart()
            break
        case 2:
            populateChartDataTwo()
            RefreshChart()
            break
        default:
            RefreshChart()
            break
        }
    }
    
    //todo: let this be the monthly view
    func populateChartData() { // any number of data sets can be specified in this case.
        xAxis = ["29", "28", "27", "26", "25", "24", "23", "22", "21", "20", "19", "18", "17", "16", "15", "14", "13", "12", "11", "10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "0" ]
        let yAxis1 = ["56", "56", "54", "56", "54", "53", "59", "51", "58", "56", "50", "58", "55", "56", "50", "58", "59", "51", "58", "51", "53", "52", "56", "56", "52", "52", "59", "53", "55", "52"]
        let yAxis2 = ["23", "26", "29", "28", "25", "28", "21", "24", "22", "26", "22", "23", "21", "23", "22", "22", "29", "22", "26", "22", "22", "23", "20", "23", "28", "25", "24", "24", "27", "24"]
        yAxis = [yAxis1, yAxis2]
        self.getChartData(with: xAxis, values: yAxis)
    }
    
    //todo: let this be the weekly view
    func populateChartDataTwo() { // any number of data sets can be specified in this case.
        xAxis = ["6", "5", "4", "3", "2", "1", "0"]
        let yAxis1 = ["54", "52", "52", "54", "57", "57", "50"]
        let yAxis2 = ["23", "24", "21", "21", "25", "29", "29"]
        yAxis = [yAxis1, yAxis2]
        self.getChartData(with: xAxis, values: yAxis)
    }
    
    //todo: let this be the yearly view
    func populateChartDataThree() { // any number of data sets can be specified in this case.
        xAxis = ["11", "10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]
        let yAxis1 = ["50", "59", "52", "50", "50", "56", "57", "60", "58", "51", "51", "51"]
        let yAxis2 = ["26", "25", "26", "29", "23", "24", "25", "26", "24", "24", "30", "28"]
        yAxis = [yAxis1, yAxis2]
        self.getChartData(with: xAxis, values: yAxis)
    }
    
    //todo: a fourth function, for "all"
    
    @objc func buttonClicked1(_ sender: UIButton) {
        populateChartData()
        RefreshChart()
    }
    
    @objc func buttonClicked2(_ sender: UIButton) {
        populateChartDataTwo()
        RefreshChart()
    }
    
    @objc func buttonClicked3(_ sender: UIButton) {
        populateChartDataThree()
        RefreshChart()
    }
    
    func lineChart() {
        //let lineChart = LineChart(frame: CGRect(x: 0.0, y: self.view.frame.height * 0.15, width: self.view.frame.width, height: self.view.frame.height * 0.70))
        
        myLineChart.delegate = self
        let marker: BalloonMarker = BalloonMarker(color: UIColor.black, font: UIFont(name: "Helvetica", size: 12.0)!, textColor: UIColor.black, insets: UIEdgeInsetsMake(0,0,0,0))
        marker.minimumSize = CGSize(width: 1.0, height: 35.0)
        myLineChart.lineChartView.marker = marker
        marker.chartView = myLineChart.lineChartView
        marker.chartViewController = self
       //lineChart.lineChartView.highlightValue(x: 0.0, dataSetIndex: 0)
        //self.view.addSubview(myLineChart)
        //weightPanel = UILabel.init(frame: CGRect(x:20, y: 5, width: 300, height: 50))
        //fatPanel = UILabel.init(frame: CGRect(x:self.view.frame.width - 150, y: 5, width: 300, height: 50))
        //self.view.addSubview(weightPanel!)
        //self.view.addSubview(fatPanel!)
        //addButtons()
    }
    
    func updateLabel(weight: String, fat: String) {
        weightLabel.text = weight
        fatLabel.text = fat
     //print(label)
    }
    
    func getChartData(with dataPoints: [String], values: [[String]]) {
        self.xAxis = dataPoints
        self.yAxis = values
    }
    
    
}
//The target function


