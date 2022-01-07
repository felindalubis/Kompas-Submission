//
//  WeatherService.swift
//  Kompas-Submission
//
//  Created by Felinda Gracia Lubis on 07/01/22.
//

import Foundation

class WeatherService: BaseService {
    var parameters: [URLQueryItem]?
    
    func method() -> APIService.Method {
        return .get
    }
    
    func components() -> URLComponents {
        var components = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather?")!
        components.queryItems = parameters
        return components
    }
    
    func httpBody() -> [String : String] {
        return [:]
    }
    
    func auth() -> String {
        return ""
    }
    
    
}
