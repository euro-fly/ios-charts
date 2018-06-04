//
//  LineChartView.swift
//  charts-test5
//
//  Created by Jacob on 2018/05/31.
//  Copyright © 2018 Jacob. All rights reserved.
//

import Foundation
import Charts
import UIKit

class LineChart: UIView, IAxisValueFormatter {
    let lineChartView = LineChartView()
    var lineDataEntry: [ChartDataEntry] = []
    
    var xAxis = [String]()
    var yAxis = [[String]]()
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        var date: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        if (xAxis.count == 7)  // if it's a weekly view
        {
            date = NSCalendar.current.date(byAdding: .day, value: Int(Int(xAxis[Int(value)])! * -1), to: NSDate() as Date) as Date!
            dateFormatter.dateFormat = "MM月dd日"
        }
        else if (xAxis.count == 12) // if it's a yearly view
        {
            date = NSCalendar.current.date(byAdding: .month, value: Int(Int(xAxis[Int(value)])! * -1), to: NSDate() as Date) as Date!
            dateFormatter.dateFormat = "MM月"
        }
        else if (xAxis.count == 30) {
            date = NSCalendar.current.date(byAdding: .day, value: Int(Int(xAxis[Int(value)])! * -1), to: NSDate() as Date) as Date!
            dateFormatter.dateFormat = "MM月dd日"
        }
        
        
        
        //print() // 2001/01/0
        return dateFormatter.string(from: date)
    }
    public func setValues(values: [String]) {
        self.xAxis = values
    }

    var delegate: GetChartData! {
        didSet {
            populateData()
            lineChartSetup()
        }
    }
    
    func populateData() {
        xAxis = delegate.xAxis
        yAxis = delegate.yAxis
    }
    
    func lineChartSetup() {
        self.backgroundColor = UIColor.white
        self.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        //lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: ChartEasingOption.easeInSine)
        setLineChart(dataPoints: xAxis, values: yAxis)
    }
    
    func setLineChart(dataPoints: [String], values: [[String]]) {
        lineChartView.noDataTextColor = UIColor.white
        lineChartView.noDataText = "NO DATA"
        lineChartView.backgroundColor = UIColor.white
        
        /* for i in 0..<dataPoints.count {
            let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i])!)
            lineDataEntry.append(dataPoint)
        } */
        //let gradientColors = [UIColor.purple.cgColor, UIColor.clear.cgColor] as CFArray
        //let colorLocations: [CGFloat] = [1.0, 0.0]
        let colors: [UIColor] = [UIColor.blue, UIColor.purple]
        //guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else { print("gradient error"); return }
        let labels: [String] = ["Weight", "Fat"]
        let axes: [Charts.ChartYAxis.AxisDependency] = [Charts.YAxis.AxisDependency.left, Charts.YAxis.AxisDependency.right]
        let chartData = LineChartData()
        for i in 0..<values.count {
            lineDataEntry = []
            for j in 0..<dataPoints.count {
                let dataPoint = ChartDataEntry(x: Double(j), y: Double(values[i][j])!)
                lineDataEntry.append(dataPoint)
            }
            let chartDataSet = LineChartDataSet(values: lineDataEntry, label: labels[i])
            chartData.addDataSet(chartDataSet)
            chartDataSet.colors = [colors[i]]
            chartDataSet.lineWidth = 3.0
            chartDataSet.setCircleColor(colors[i])
            chartDataSet.circleHoleColor = colors[i]
            chartDataSet.circleRadius = 0.0
            //chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
            chartDataSet.drawFilledEnabled = true
            chartDataSet.axisDependency = axes[i]
            chartDataSet.mode = .cubicBezier
            chartDataSet.cubicIntensity = 0.2
        }
        
        chartData.setDrawValues(false)
        
        let xAxis = XAxis()
        xAxis.valueFormatter = self
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.valueFormatter = xAxis.valueFormatter
        lineChartView.xAxis.setLabelCount(5, force: true)
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.rightAxis.enabled = true
        lineChartView.rightAxis.axisMaximum = 100.0
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = true
        lineChartView.data = chartData
        
        
    }
    
    
    
}
