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

class LineChart: UIView {
    let lineChartView = LineChartView()
    var lineDataEntry: [ChartDataEntry] = []
    
    var xAxis = [String]()
    var yAxis = [[String]]()

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
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: ChartEasingOption.easeInSine)
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
        let gradientColors = [UIColor.purple.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        let colors: [UIColor] = [UIColor.blue, UIColor.green]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else { print("gradient error"); return }
        let labels: [String] = ["Weight", "Fat"]
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
            chartDataSet.lineWidth = 2.0
            chartDataSet.setCircleColor(colors[i])
            chartDataSet.circleHoleColor = colors[i]
            chartDataSet.circleRadius = 0.0
            chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
            chartDataSet.drawFilledEnabled = true
        }
        
        chartData.setDrawValues(false)
        
        let formatter: ChartFormatter = ChartFormatter()
        formatter.setValues(values: dataPoints)
        let xaxis:XAxis = XAxis()
        xaxis.valueFormatter = formatter
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.valueFormatter = xaxis.valueFormatter
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = true
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = true
        lineChartView.data = chartData
        
        
        
        
    }
    
    
    
}
