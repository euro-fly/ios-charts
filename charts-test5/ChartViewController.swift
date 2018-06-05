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
    var xAxis = [String]()
    var yAxis = [[String]]()
    
    var weightPanel: UILabel?
    var fatPanel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateChartData()
        lineChart()
    }

    
     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        RefreshChart()
    }
    
    func RefreshChart() {
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
        lineChart()
        self.view.setNeedsDisplay()
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
        let lineChart = LineChart(frame: CGRect(x: 0.0, y: self.view.frame.height * 0.15, width: self.view.frame.width, height: self.view.frame.height * 0.85))
        lineChart.delegate = self
        let marker: BalloonMarker = BalloonMarker(color: UIColor.black, font: UIFont(name: "Helvetica", size: 12.0)!, textColor: UIColor.black, insets: UIEdgeInsetsMake(0,0,0,0))
        marker.minimumSize = CGSize(width: 1.0, height: 35.0)
        lineChart.lineChartView.marker = marker
        marker.chartView = lineChart.lineChartView
        marker.chartViewController = self
       //lineChart.lineChartView.highlightValue(x: 0.0, dataSetIndex: 0)
        self.view.addSubview(lineChart)
        weightPanel = UILabel.init(frame: CGRect(x:self.view.frame.width * 0.10, y: 5, width: self.view.frame.width * 0.30, height: 50))
        fatPanel = UILabel.init(frame: CGRect(x:self.view.frame.width * 0.55, y: 5, width: self.view.frame.width * 0.50, height: 50))
        self.view.addSubview(weightPanel!)
        self.view.addSubview(fatPanel!)
        addButtons()
    }
    
    func addButtons() { //NOTE: figure out how to do this without specifying the positions manually
        let button1 = UIButton.init(type: .roundedRect)
        button1.frame = CGRect(x:self.view.frame.width * 0.40, y: self.view.frame.height * 0.10, width: self.view.frame.width * 0.20, height: 10)
        button1.setTitle("1ヶ月間", for: .normal)
        button1.addTarget(self, action: #selector(buttonClicked1(_ :)), for: .touchUpInside)
        self.view.addSubview(button1)
        
        let button2 = UIButton.init(type: .roundedRect)
        button2.frame = CGRect(x:self.view.frame.width * 0.60, y: self.view.frame.height * 0.10, width: self.view.frame.width * 0.20, height: 10)
        button2.setTitle("1週間", for: .normal)
        button2.addTarget(self, action: #selector(buttonClicked2(_ :)), for: .touchUpInside)
        self.view.addSubview(button2)
        
        let button3 = UIButton.init(type: .roundedRect)
        button3.frame = CGRect(x:self.view.frame.width * 0.20, y: self.view.frame.height * 0.10, width: self.view.frame.width * 0.20, height: 10)
        button3.setTitle("1年間", for: .normal)
        button3.addTarget(self, action: #selector(buttonClicked3(_ :)), for: .touchUpInside)
        self.view.addSubview(button3)
    }
    
    func updateLabel(weight: String, fat: String) {
        weightPanel?.text = weight
        fatPanel?.text = fat
     //print(label)
    }
    
    func getChartData(with dataPoints: [String], values: [[String]]) {
        self.xAxis = dataPoints
        self.yAxis = values
    }
    
    
}
//The target function


