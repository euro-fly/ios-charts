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

class ChartViewController: UIViewController, GetChartData {
    var xAxis = [String]()
    var yAxis = [[String]]()
    
   
    @IBAction func myButton1(_ sender: Any) {
        print("Button press 1")
        populateChartData()
        RefreshChart()
    }
    @IBAction func myButton2(_ sender: Any) {
        
    }
    
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
        let yAxis1 = ["76", "78", "79", "71", "70", "66", "61", "50", "66", "63", "65", "56", "58", "59", "77", "78", "79", "65", "54", "75", "62", "69", "62", "50", "54", "51", "74", "62", "54", "80"]
        let yAxis2 = ["9", "25", "27", "23", "24", "7", "27", "26", "27", "29", "5", "17", "22", "9", "29", "20", "9", "18", "7", "11", "26", "25", "29", "29", "13", "26", "15", "25", "18", "24"]
        yAxis = [yAxis1, yAxis2]
        self.getChartData(with: xAxis, values: yAxis)
    }
    
    //todo: let this be the weekly view
    func populateChartDataTwo() { // any number of data sets can be specified in this case.
        xAxis = ["6", "5", "4", "3", "2", "1", "0"]
        let yAxis1 = ["68", "66", "52", "61", "66", "63", "60"]
        let yAxis2 = ["7", "13", "29", "14", "14", "29", "26"]
        yAxis = [yAxis1, yAxis2]
        self.getChartData(with: xAxis, values: yAxis)
    }
    
    //todo: let this be the yearly view
    func populateChartDataThree() { // any number of data sets can be specified in this case.
        xAxis = ["11", "10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]
        let yAxis1 = ["50", "64", "59", "74", "66", "62", "62", "78", "67", "73", "60", "70"]
        let yAxis2 = ["29", "20", "25", "26", "6", "9", "8", "16", "7", "9", "8", "10"]
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
        let marker: BalloonMarker = BalloonMarker(color: UIColor.blue, font: UIFont(name: "Helvetica", size: 12.0)!, textColor: UIColor.black, insets: UIEdgeInsetsMake(7.0, 7.0, 25.0, 7.0))
        marker.minimumSize = CGSize(width: 75.0, height: 35.0)
        lineChart.lineChartView.marker = marker
        self.view.addSubview(lineChart)
        addButtons()
    }
    
    func addButtons() { //NOTE: figure out how to do this without specifying the positions manually
        let button1 = UIButton.init(type: .roundedRect)
        button1.frame = CGRect(x:self.view.frame.width * 0.20, y: self.view.frame.height * 0.10, width: self.view.frame.width * 0.20, height: 50)
        button1.setTitle("一ヶ月間", for: .normal)
        button1.addTarget(self, action: #selector(buttonClicked1(_ :)), for: .touchUpInside)
        self.view.addSubview(button1)
        
        let button2 = UIButton.init(type: .roundedRect)
        button2.frame = CGRect(x:self.view.frame.width * 0.40, y: self.view.frame.height * 0.10, width: self.view.frame.width * 0.20, height: 50)
        button2.setTitle("一週間", for: .normal)
        button2.addTarget(self, action: #selector(buttonClicked2(_ :)), for: .touchUpInside)
        self.view.addSubview(button2)
        
        let button3 = UIButton.init(type: .roundedRect)
        button3.frame = CGRect(x:self.view.frame.width * 0.60, y: self.view.frame.height * 0.10, width: self.view.frame.width * 0.20, height: 50)
        button3.setTitle("一年間", for: .normal)
        button3.addTarget(self, action: #selector(buttonClicked3(_ :)), for: .touchUpInside)
        self.view.addSubview(button3)
    }
    
    func getChartData(with dataPoints: [String], values: [[String]]) {
        self.xAxis = dataPoints
        self.yAxis = values
    }
    
    
}
//The target function


