//
//  ViewController.swift
//  Kompas-Submission
//
//  Created by Felinda Gracia Lubis on 07/01/22.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var contentView: WeatherView!
    var viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonSetup()
        fetchData()
    }
    
    func commonSetup() {
        contentView.scrollView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    func fetchData() {
        viewModel.fetchWeatherData(location: "Serang") { [weak self] result in
            DispatchQueue.main.async {
                self?.setDataToView(data: result)
            }
        }
    }
    
    func setDataToView(data: WeatherModel) {
        contentView.cityLabel.text = "\(data.name), \(data.sys.country)"
        contentView.updateTimeLabel.text = "Update at: \(data.dt.getStringDate(dateStyle: .full))"
        contentView.weatherLabel.text = data.weather.first?.main
        contentView.tempLabel.text = "\(data.main.temp.truncateDecimals(n: 1))°C"
        contentView.minTempLabel.text = "Min. Temp: \(data.main.tempMin.truncateDecimals(n: 1))°C"
        contentView.maxTempLabel.text = "Max. Temp: \(data.main.tempMax.truncateDecimals(n: 1))°C"
        contentView.sunriseLabel.text = data.sys.sunrise.getStringDate(dateStyle: .time)
        contentView.sunsetLabel.text = data.sys.sunset.getStringDate(dateStyle: .time)
        contentView.windLabel.text = data.wind.speed.truncateDecimals(n: 1)
        contentView.pressureLabel.text = data.main.pressure.truncateDecimals(n: 1)
        contentView.humidLabel.text = data.main.humidity.truncateDecimals(n: 1)
    }
    
    @objc func didPullToRefresh() {
    
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
            self.contentView.scrollView.refreshControl?.endRefreshing()
        })
    }
}

