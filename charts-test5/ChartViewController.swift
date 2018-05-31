//
//  ChartViewController.swift
//  charts-test5
//
//  Created by Jacob on 2018/05/31.
//  Copyright © 2018 Jacob. All rights reserved.
//

import Foundation
import Charts

protocol GetChartData {
    func getChartData(with dataPoints: [String], values: [[String]])
    var xAxis: [String] {get set}
    var yAxis: [[String]] {get set}
}

class ChartViewController: UIViewController, GetChartData {
    var xAxis = [String]()
    var yAxis = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateChartData()
        lineChart()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lineChart()
        self.view.setNeedsDisplay()
    }
    
    func populateChartData() {
        xAxis = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24" ]
        let yAxis1 = ["34", "100", "150", "10", "80", "92", "130", "160", "200", "110", "160", "180", "190", "90", "50", "120", "140", "190", "210", "180", "60", "180", "160", "330" ]
        let yAxis2 = ["12", "21", "15", "45", "39", "55", "19", "23", "11", "38", "29", "47",
                      "12", "21", "15", "45", "39", "55", "19", "23", "11", "38", "29", "47"]
        yAxis = [yAxis1, yAxis2]
        self.getChartData(with: xAxis, values: yAxis)
    }
    
    func lineChart() {
        let lineChart = LineChart(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height))
        lineChart.delegate = self
        self.view.addSubview(lineChart)
    }
    
    func getChartData(with dataPoints: [String], values: [[String]]) {
        self.xAxis = dataPoints
        self.yAxis = values
    }
}



public class ChartFormatter: NSObject, IAxisValueFormatter {
    var xAxis = [String]()
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return xAxis[Int(value)]
    }
    public func setValues(values: [String]) {
        self.xAxis = values
    }
}
