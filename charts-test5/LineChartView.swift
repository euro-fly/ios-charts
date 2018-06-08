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

@objc class LineChart: UIView, IAxisValueFormatter {
    let lineChartView = LineChartView()
    var lineDataEntry: [ChartDataEntry] = []
    
    var xAxis = [String]()
    var yAxis = [[String]]()
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        var date: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        if (xAxis.count == 7)  // if it's a weekly view
        {
            date = NSCalendar.current.date(byAdding: .day, value: Int((6 - value) * -1), to: NSDate() as Date) as Date!
            dateFormatter.dateFormat = "MM月dd日"
        }
        else if (xAxis.count == 12) // if it's a yearly view
        {
            date = NSCalendar.current.date(byAdding: .month, value: Int((11 - value) * -1), to: NSDate() as Date) as Date!
            dateFormatter.dateFormat = "MM月"
        }
        else if (xAxis.count == 30) {
            date = NSCalendar.current.date(byAdding: .day, value: Int((29 - value) * -1), to: NSDate() as Date) as Date!
            dateFormatter.dateFormat = "MM月dd日"
        }
        else {
            date = NSCalendar.current.date(byAdding: .year, value: Int((1 - value) * -3), to: NSDate() as Date) as Date!
            dateFormatter.dateFormat = "YYYY年MM月dd日"
        }
        return dateFormatter.string(from: date)
    }
    public func setValues(values: [String]) {
        self.xAxis = values
    }

    @objc var delegate: getChartData2! {
        didSet {
            populateData()
            lineChartSetup()
        }
    }
    
    @objc func populateData() {
        xAxis = delegate.xAxis as! [String]
        yAxis = delegate.yAxis as! [[String]]
    }
    
    @objc func lineChartSetup() {
        self.backgroundColor = UIColor.white
        self.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        //lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: ChartEasingOption.easeInSine)
        setLineChart(dataPoints: xAxis, values: yAxis)
    }
    
    @objc func setLineChart(dataPoints: [String], values: [[String]]) {
        lineChartView.noDataTextColor = UIColor.white
        lineChartView.noDataText = "NO DATA"
        lineChartView.backgroundColor = UIColor.white
        
        let colors: [UIColor] = [UIColorFromRGB(rgbValue: 0x111E6C), UIColorFromRGB(rgbValue: 0x0F52BA)]
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
            chartDataSet.drawCirclesEnabled = true
            chartDataSet.circleColors = [colors[i]]
            chartDataSet.circleRadius = 5.0
            chartDataSet.fillAlpha = 0.0
            //chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
            chartDataSet.drawFilledEnabled = true
            chartDataSet.axisDependency = axes[i]
            chartDataSet.mode = .cubicBezier
            chartDataSet.cubicIntensity = 0.2
        }
        
        chartData.setDrawValues(false)
        
        
        //todo: refactor all of this.
        let xAxis = XAxis()
        xAxis.valueFormatter = self
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.valueFormatter = xAxis.valueFormatter
        lineChartView.xAxis.setLabelCount(min(5, chartData.dataSets[0].entryCount), force: true)
        lineChartView.xAxis.labelTextColor = UIColor.gray
        lineChartView.xAxis.labelFont = UIFont(name: "Helvetica", size: 8)!
        lineChartView.rightAxis.drawLimitLinesBehindDataEnabled = true
        let bodyFatTargetLine = ChartLimitLine(limit: chartData.dataSets[1].yMin - 5, label: "体脂肪率")
        let bodyWeightTargetLine = ChartLimitLine(limit: chartData.dataSets[0].yMin - 5, label: "体量")
        bodyFatTargetLine.lineDashLengths = [0.5]
        bodyWeightTargetLine.lineDashLengths = [0.5]
        bodyFatTargetLine.lineColor = UIColorFromRGB(rgbValue: 0x0F52BA)
        bodyWeightTargetLine.lineColor = UIColorFromRGB(rgbValue: 0x111E6C)
        lineChartView.rightAxis.addLimitLine(bodyFatTargetLine)
        lineChartView.leftAxis.addLimitLine(bodyWeightTargetLine)
        lineChartView.leftAxis.drawLimitLinesBehindDataEnabled = true
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.rightAxis.enabled = true
        lineChartView.rightAxis.axisMaximum = chartData.dataSets[1].yMax + 10
        lineChartView.rightAxis.axisMinimum = 5.0
        lineChartView.leftAxis.drawGridLinesEnabled = true
        lineChartView.leftAxis.gridColor = UIColorFromRGB(rgbValue: 0x111E6C)
        lineChartView.leftAxis.gridLineWidth = 1.5
        //lineChartView.rightAxis.gridLineWidth = 1
        lineChartView.rightAxis.gridColor = UIColorFromRGB(rgbValue: 0x0F52BA)
        lineChartView.leftAxis.drawLabelsEnabled = true
        lineChartView.data = chartData
    }
    
    @objc func removeLimitLine() {
        lineChartView.rightAxis.removeAllLimitLines()
        lineChartView.leftAxis.removeAllLimitLines()
    }
    
    
    
}
