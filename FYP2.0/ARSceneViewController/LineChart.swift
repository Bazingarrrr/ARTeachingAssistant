//
//  LineChart.swift
//  FYP2.3
//
//  Created by yi 万 on 2021/4/8.
//

import UIKit
import Charts

class VelocityChartViewController: UIViewController {

    let chartView = LineChartView()

    var dataEntries = [ChartDataEntry]()

    var xValue: Double = 8

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupInitialDataEntries()
        setupChartData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(didUpdatedChartView), userInfo: nil, repeats: true)
    }

    @objc func didUpdatedChartView() {
        let newDataEntry = ChartDataEntry(x: xValue,
                                          y: Double.random(in: 0...50))
        updateChartView(with: newDataEntry, dataEntries: &dataEntries)
        xValue += 1
    }

    func setupViews() {
        
        
        view.frame.size.height = 150
        view.frame.size.width = 150
        
        view.addSubview(chartView)
        
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        chartView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        chartView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }

    func setupInitialDataEntries() {
        (0..<Int(xValue)).forEach {
            let dataEntry = ChartDataEntry(x: Double($0), y: 0)
            dataEntries.append(dataEntry)
        }
    }

    func setupChartData() {
        // 1
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "set1")
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.setColor(NSUIColor.red)
        chartDataSet.mode = .linear

        // 2
        let chartData = LineChartData(dataSet: chartDataSet)
        chartView.data = chartData
        chartView.xAxis.labelPosition = .bottom
    }

    func updateChartView(with newDataEntry: ChartDataEntry, dataEntries: inout [ChartDataEntry]) {
        if let oldEntry = dataEntries.first {
            dataEntries.removeFirst()
            chartView.data?.removeEntry(oldEntry, dataSetIndex: 0)
        }

        dataEntries.append(newDataEntry)
        chartView.data?.addEntry(newDataEntry, dataSetIndex: 0)

        chartView.notifyDataSetChanged()
        chartView.moveViewToX(newDataEntry.x)
    }
}
