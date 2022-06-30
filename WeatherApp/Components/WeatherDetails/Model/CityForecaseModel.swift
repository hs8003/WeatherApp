//
//  CityForecaseModel.swift
//  WeatherApp
//
//  Created by HarshitSharma on 30/06/22.
//

import Foundation


import Foundation

// MARK: - Welcome
struct ForcastWeather: Codable {
    let list: [List]?
}

// MARK: - List
struct List: Codable {
    let dt: Double?
    let main: Main?
    let weather: [Weather]?
}


