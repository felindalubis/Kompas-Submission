//
//  WeatherModel.swift
//  Kompas-Submission
//
//  Created by Felinda Gracia Lubis on 07/01/22.
//

import Foundation

struct WeatherModel: Codable {
    let weather: [Weathers]
    let main: Main
    let wind: Wind
    let dt: Double
    let sys: Sys
    let name: String
}

struct Weathers: Codable {
    let main: String
    let description: String
}

struct Main: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Wind: Codable {
    let speed: Double
}

struct Sys: Codable {
    let country: String
    let sunrise: Double
    let sunset: Double
}


