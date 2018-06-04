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
    
    func populateChartData() { // any number of data sets can be specified in this case.
        xAxis = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24" ]
        let yAxis1 = ["34", "100", "150", "10", "80", "92", "130", "160", "200", "110", "160", "180", "190", "90", "50", "120", "140", "190", "210", "180", "60", "180", "160", "330" ]
        let yAxis2 = ["12", "21", "15", "45", "39", "55", "19", "23", "11", "38", "29", "47",
                      "12", "21", "15", "45", "39", "55", "19", "23", "11", "38", "29", "47"]
        yAxis = [yAxis1, yAxis2]
        self.getChartData(with: xAxis, values: yAxis)
    }
    
    func populateChartDataTwo() { // any number of data sets can be specified in this case.
        xAxis = ["1", "2", "3", "4", "5", "6", "7"]
        let yAxis1 = ["34", "100", "150", "10", "80", "92", "13"]
        let yAxis2 = ["12", "21", "15", "45", "39", "55", "19"]
        yAxis = [yAxis1, yAxis2]
        self.getChartData(with: xAxis, values: yAxis)
    }
    
    func populateChartDataThree() { // any number of data sets can be specified in this case.
        xAxis = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        let yAxis1 = ["80", "92", "130", "160", "200", "110", "160", "180", "190", "90"]
        let yAxis2 = ["90", "42", "70", "10", "90", "130", "120", "80", "64", "30"]
        yAxis = [yAxis1, yAxis2]
        self.getChartData(with: xAxis, values: yAxis)
    }
    
    @objc func buttonClicked1(_ sender: UIButton) {
        print("Button press 1")
        populateChartData()
        RefreshChart()
    }
    
    @objc func buttonClicked2(_ sender: UIButton) {
        print("Button press 2")
        populateChartDataTwo()
        RefreshChart()
    }
    
    @objc func buttonClicked3(_ sender: UIButton) {
        print("Button press 2")
        populateChartDataThree()
        RefreshChart()
    }
    
    
    
    func lineChart() {
        let lineChart = LineChart(frame: CGRect(x: 0.0, y: self.view.frame.height * 0.15, width: self.view.frame.width, height: self.view.frame.height * 0.85))
        lineChart.delegate = self
        let marker: BalloonMarker = BalloonMarker(color: UIColor.red, font: UIFont(name: "Helvetica", size: 12.0)!, textColor: UIColor.black, insets: UIEdgeInsetsMake(7.0, 7.0, 25.0, 7.0))
        marker.minimumSize = CGSize(width: 75.0, height: 35.0)
        lineChart.lineChartView.marker = marker
        self.view.addSubview(lineChart)
        addButtons()
    }
    
    func addButtons() { //NOTE: figure out how to do this without specifying the positions manually
        let button1 = UIButton.init(type: .roundedRect)
        button1.frame = CGRect(x:self.view.frame.width * 0.20, y: self.view.frame.height * 0.10, width: self.view.frame.width * 0.20, height: 50)
        button1.setTitle("24h View", for: .normal)
        button1.addTarget(self, action: #selector(buttonClicked1(_ :)), for: .touchUpInside)
        self.view.addSubview(button1)
        
        let button2 = UIButton.init(type: .roundedRect)
        button2.frame = CGRect(x:self.view.frame.width * 0.40, y: self.view.frame.height * 0.10, width: self.view.frame.width * 0.20, height: 50)
        button2.setTitle("7d View", for: .normal)
        button2.addTarget(self, action: #selector(buttonClicked2(_ :)), for: .touchUpInside)
        self.view.addSubview(button2)
        
        let button3 = UIButton.init(type: .roundedRect)
        button3.frame = CGRect(x:self.view.frame.width * 0.60, y: self.view.frame.height * 0.10, width: self.view.frame.width * 0.20, height: 50)
        button3.setTitle("10d View", for: .normal)
        button3.addTarget(self, action: #selector(buttonClicked3(_ :)), for: .touchUpInside)
        self.view.addSubview(button3)
        
    }
    
    func getChartData(with dataPoints: [String], values: [[String]]) {
        self.xAxis = dataPoints
        self.yAxis = values
    }
    
    
}
//The target function

public class ChartFormatter: NSObject, IAxisValueFormatter {
    var xAxis = [String]()
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return xAxis[Int(value)]
    }
    public func setValues(values: [String]) {
        self.xAxis = values
    }
}
