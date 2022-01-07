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
        setupUI()
        fetchData()
    }
    
    
    func setupUI() {
        contentView.scrollView.refreshControl = UIRefreshControl()
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
        contentView.tempLabel.text = "\(String(format: "%.1f", data.main.temp))°C"
        contentView.minTempLabel.text = "Min. Temp: \(String(format: "%.1f", data.main.tempMin))°C"
        contentView.maxTempLabel.text = "Max. Temp: \(String(format: "%.1f", data.main.tempMax))°C"
        contentView.sunriseLabel.text = data.sys.sunrise.getStringDate(dateStyle: .time)
        contentView.sunsetLabel.text = data.sys.sunset.getStringDate(dateStyle: .time)
        contentView.windLabel.text = String(format: "%.1f", data.wind.speed)
        contentView.pressureLabel.text = String(format: "%1.f", data.main.pressure)
        contentView.humidLabel.text = String(format: "%.1f", data.main.humidity)
    }
    
    @objc func didPullToRefresh() {
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
            self.contentView.scrollView.refreshControl?.endRefreshing()
        })
    }
}

