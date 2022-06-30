//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by HarshitSharma on 30/06/22.
//

import Foundation
import UIKit

class NetworkManager {
  
  private init(){}
  static let shared = NetworkManager()
  
  private let imageCache = NSCache<NSString,UIImage>()
  
  func getCityLatLong(_ cityName: String, complitionHandler: @escaping (CurrentWeather?) -> Void) {
    
    let stringUrl = "\(ApiConstants.baseAddress)weather?q=\(cityName)&appid=\(AuthKeys.ApiKey)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    guard let url = URL(string: stringUrl ?? "") else {return}
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print(error)
        return
      }
      
      guard let httpRespnse = response as? HTTPURLResponse, (200...299).contains(httpRespnse.statusCode) else {
        print(response ?? "")
        return
      }
      
      guard let data = data else {return}
      
      let model = try? JSONDecoder().decode(CurrentWeather.self, from: data)
      complitionHandler(model)
      
    }.resume()
  }
  
  func getCityForecast(_ lat: Double, _ long: Double, complitionHandler: @escaping (ForcastWeather?) -> Void) {
    
    let stringUrl = "\(ApiConstants.baseAddress)forecast?lat=\(lat)&lon=\(long)&appid=\(AuthKeys.ApiKey)"
    guard let url = URL(string: stringUrl) else {return}
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print(error)
        return
      }
      
      guard let httpRespnse = response as? HTTPURLResponse, (200...299).contains(httpRespnse.statusCode) else {
        print(response ?? "")
        return
      }
      
      guard let data = data else {return}
      
      let model = try? JSONDecoder().decode(ForcastWeather.self, from: data)
      complitionHandler(model)
      
    }.resume()
  }
  
  func downloadImage(url: URL, completion: @escaping(_ image: UIImage?,_ error: Error?) -> Void){
    
    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString ) {
      completion(cachedImage, nil)
      
    } else {
      
      let request = URLRequest(url: url)
      URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        if let error = error{
          completion(nil, AppError.misc(error.localizedDescription))
          
        } else if let data = data {
          if let image = UIImage(data: data) {
            self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            completion(image, nil)
          }
        } else {
          completion(nil, AppError.misc(error?.localizedDescription ?? "Something went wrong!"))
        }
      }.resume()
    }
  }
}
