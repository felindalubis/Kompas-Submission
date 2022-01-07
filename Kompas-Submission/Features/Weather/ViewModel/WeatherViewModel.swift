//
//  WeatherViewModel.swift
//  Kompas-Submission
//
//  Created by Felinda Gracia Lubis on 07/01/22.
//

import Foundation

class WeatherViewModel {
    
    func fetchWeatherData(latitude: String, longitude: String, completion: @escaping (WeatherModel) -> Void) {
        let request = WeatherService()
        let apiToken = Bundle.main.infoDictionary?["API_KEY"]  as? String
        request.parameters = [
            URLQueryItem(name: "lat", value: latitude),
            URLQueryItem(name: "lon", value: longitude),
            URLQueryItem(name: "appId", value: apiToken),
            URLQueryItem(name: "units", value: "metric")
        ]
        APIService.APIRequest(model: WeatherModel.self, req: request) { [weak self] result in
            switch result {
            case .success(let result):
                guard let weatherData = result as? WeatherModel else { return }
                self?.cacheWeatherData(weatherData: weatherData)
                completion(weatherData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func cacheWeatherData(weatherData: WeatherModel) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(weatherData)
            UserDefaults.standard.set(data, forKey: "weatherData")
        } catch let error {
            print("Error encoding data \(error.localizedDescription)")
        }
    }
    
    func getDataFromCache() -> WeatherModel? {
        if let data = UserDefaults.standard.data(forKey: "weatherData") {
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherModel.self, from: data)
                return weatherData
            } catch let error {
                print("Error decoding data \(error.localizedDescription)")
            }
        }
        return nil
    }
}
