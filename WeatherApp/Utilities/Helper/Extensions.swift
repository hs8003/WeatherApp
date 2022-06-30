//
//  Extensions.swift
//  WeatherApp
//
//  Created by HarshitSharma on 30/06/22.
//

import Foundation
import UIKit

extension Double {
  
  func ConvertKivToC() -> String {
    return  "\(String(format: "%.0f", self - 273.15))°"
  }
  
  func ToFormatedDate(_ format : String) -> String {
    let date = Date(timeIntervalSince1970: self)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
  }
}


extension UIImageView {
  
  func downloadImage(_ url: String?, _ placeHolder: UIImage? = nil){
    guard let urlString = url else { return }
    guard let url = URL(string: urlString) else { return }
    
    DispatchQueue.global(qos: .background).async {
      NetworkManager.shared.downloadImage(url: url) { (image, error) in
        if let error = error {
          print(error.localizedDescription)
        } else {
          DispatchQueue.main.async { [weak self] in
            self?.image = image
          }
        }
      }
    }
  }
}
