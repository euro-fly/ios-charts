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

extension String  {
    var isNumber: Bool { return Int(self) != nil || Double(self) != nil }
}

protocol GetChartData {
    func getChartData(with dataPoints: [String], values: [[String]])
    var xAxis: [String] {get set}
    var yAxis: [[String]] {get set}
}

@objc class ChartViewController: UIViewController, GetChartData {
    @IBOutlet weak var myLineChart: LineChart!
    var xAxis = [String]()
    var yAxis = [[String]]()
    
    var xAxisMonthly = ["29", "28", "27", "26", "25", "24", "23", "22", "21", "20", "19", "18", "17", "16", "15", "14", "13", "12", "11", "10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "0" ]
    var yAxisMonthly1 = ["56", "56", "54", "56", "54", "53", "59", "51", "58", "56", "50", "58", "55", "56", "50", "58", "59", "51", "58", "51", "53", "52", "56", "56", "52", "52", "59", "53", "55", "52"]
    var yAxisMonthly2 = ["23", "26", "29", "28", "25", "28", "21", "24", "22", "26", "22", "23", "21", "23", "22", "22", "29", "22", "26", "22", "22", "23", "20", "23", "28", "25", "24", "24", "27", "24"]
    
    var xAxisWeekly = ["6", "5", "4", "3", "2", "1", "0"]
    var yAxisWeekly1 = ["54", "52", "52", "54", "57", "57", "50"]
    var yAxisWeekly2 = ["23", "24", "21", "21", "25", "29", "29"]
    
    var xAxisYearly = ["11", "10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]
    var yAxisYearly1 = ["50", "59", "52", "50", "50", "56", "57", "60", "58", "51", "51", "51"]
    var yAxisYearly2 = ["26", "25", "26", "29", "23", "24", "25", "26", "24", "24", "30", "28"]
    
    @IBOutlet weak var myRotateButton: UIButton!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBAction func updateChart(_ sender: Any) {
        let alertController = UIAlertController(title: "Update", message: "Update weight and body fat percentage", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            //getting the input values from user
            let weight = alertController.textFields?[0].text
            let fat = alertController.textFields?[1].text
            if ((weight?.isNumber)! && (fat?.isNumber)!) {
                self.yAxis[0][self.xAxis.count - 1] = weight!
                self.yAxis[1][self.xAxis.count - 1] = fat!
                self.getChartData(with: self.xAxis, values: self.yAxis)
                self.RefreshChart()
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }

        alertController.addTextField { (textField) in
            textField.placeholder = "Body Weight"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Fat Percentage"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(myLineChart)
        self.view.addSubview(buttonSet)
        self.view.addSubview(weightLabel)
        self.view.addSubview(fatLabel)
        populateChartDataThree()
        lineChart()
    }

    func RefreshChart() {
        myLineChart.removeLimitLine()
        lineChart()
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
    
    func populateChartData() { // any number of data sets can be specified in this case.
        xAxis = xAxisMonthly
        yAxis = [yAxisMonthly1, yAxisMonthly2]
        self.getChartData(with: xAxis, values: yAxis)
    }
    
    func populateChartDataTwo() { // any number of data sets can be specified in this case.
        xAxis = xAxisWeekly
        yAxis = [yAxisWeekly1, yAxisWeekly2]
        self.getChartData(with: xAxis, values: yAxis)
    }
    
    func populateChartDataThree() { // any number of data sets can be specified in this case.
        xAxis = xAxisYearly
        yAxis = [yAxisYearly1, yAxisYearly2]
        self.getChartData(with: xAxis, values: yAxis)
    }
    
    func lineChart() {
        myLineChart.delegate = self
        let marker: BalloonMarker = BalloonMarker(color: UIColor.black, font: UIFont(name: "Helvetica", size: 12.0)!, textColor: UIColor.black, insets: UIEdgeInsetsMake(0,0,0,0))
        marker.minimumSize = CGSize(width: 1.0, height: 35.0)
        myLineChart.lineChartView.marker = marker
        marker.chartView = myLineChart.lineChartView
        marker.chartViewController = self
    }
    
    func updateLabel(weight: String, fat: String) {
        weightLabel.text = weight
        fatLabel.text = fat
    }
    
    func getChartData(with dataPoints: [String], values: [[String]]) {
        self.xAxis = dataPoints
        self.yAxis = values
    }
}


