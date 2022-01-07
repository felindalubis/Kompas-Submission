//
//  ViewController.swift
//  Kompas-Submission
//
//  Created by Felinda Gracia Lubis on 07/01/22.
//

import UIKit
import CoreLocation
import Network

class WeatherViewController: UIViewController {
    
    @IBOutlet var contentView: WeatherView!
    private let viewModel = WeatherViewModel()
    private var locationManager: CLLocationManager?
    private let monitor = NWPathMonitor()
    private var isNetworkAvailable = false
    
    private func checkNetworkAvailability() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.isNetworkAvailable = true
            } else {
                self?.isNetworkAvailable = false
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonSetup()
    }
    
    private func commonSetup() {
        contentView.scrollView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        checkNetworkAvailability()
        fetchData()
    }
    
    private func fetchData() {
        if isNetworkAvailable {
            self.getUserLocation { [weak self] lat, lon in
                self?.viewModel.fetchWeatherData(latitude: lat, longitude: lon) { result in
                    DispatchQueue.main.async {
                        self?.setDataToView(data: result)
                    }
                }
            }
        } else {
            guard let data = self.viewModel.getDataFromCache() else { return }
            self.setDataToView(data: data)
        }
    }
    
    private func setDataToView(data: WeatherModel) {
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
        self.fetchData()
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.contentView.scrollView.refreshControl?.endRefreshing()
        })
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    private func getUserLocation(completion: @escaping(String, String) -> Void) {
        self.locationManager?.startUpdatingLocation()
        guard let location = locationManager?.location?.coordinate else { return }
        let lat = String(describing: location.latitude)
        let lon = String(describing: location.longitude)
        completion(lat, lon)
        self.locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting user's location: \(error)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        fetchData()
    }
}

