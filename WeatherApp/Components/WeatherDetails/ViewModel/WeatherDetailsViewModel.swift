//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by HarshitSharma on 30/06/22.
//

import Foundation

class WeatherDetailsViewModel {
  
  var cityName: String!
  var currentWeather: CurrentWeather?
  var forecastWeather: ForcastWeather?
  
  func getCityForcastData(_ complition: @escaping () -> Void) {
    NetworkManager.shared.getCityLatLong(cityName) { currentWeather in
      guard let data = currentWeather else { return }
      self.currentWeather = data
      
      let coordinate = self.currentWeather?.coord
      NetworkManager.shared.getCityForecast(coordinate?.lat ?? 0.0, coordinate?.lon ?? 0.0) { forecast in
        guard let forecastWeather = forecast else {return}
        self.forecastWeather = forecastWeather
        complition()
      }
    }
  }
  
  func getNumberOfRowInSection() -> Int {
    forecastWeather?.list?.count ?? 0
  }
  
  func getWeatherObjectFor(_ indexPath: IndexPath) -> List? {
    forecastWeather?.list?[indexPath.row]
  }
  
  func getImageUrl() -> String {
    let endUrl = currentWeather?.weather?.first?.icon ?? ""
    return ApiConstants.baseUrlImage + endUrl + StringConstant.imageIdentifier
  }
}
