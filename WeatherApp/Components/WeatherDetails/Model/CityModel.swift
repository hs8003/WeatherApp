//
//  CityModel.swift
//  WeatherApp
//
//  Created by HarshitSharma on 30/06/22.
//

import Foundation

// MARK: - CityForcast
struct CurrentWeather: Codable {
  let coord: Coord?
  let weather: [Weather]?
  let main: Main?
  let dt: Double?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
  let temp, feelsLike, tempMin, tempMax: Double
  let pressure, humidity: Int
  
  enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure, humidity
  }
}

// MARK: - Weather
struct Weather: Codable {
  let id: Int
  let main, weatherDescription, icon: String
  
  enum CodingKeys: String, CodingKey {
    case id, main
    case weatherDescription = "description"
    case icon
  }
}
