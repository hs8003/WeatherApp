//
//  WeatherDetailCollectionCell.swift
//  WeatherApp
//
//  Created by HarshitSharma on 30/06/22.
//

import UIKit

class WeatherDetailCollectionCell: UICollectionViewCell {
    
  @IBOutlet weak var lblTemp: UILabel!
  @IBOutlet weak var imgCloud: UIImageView!
  @IBOutlet weak var lblHour: UILabel!
  
  @IBOutlet weak var lblMonth: UILabel!
  @IBOutlet weak var lblDay: UILabel!
  
  var weatherList: List? {
    didSet {
       displayUIData()
    }
  }
  
  func getImageUrl() -> String {
    let endUrl = weatherList?.weather?.first?.icon ?? ""
    return ApiConstants.baseUrlImage + endUrl + StringConstant.imageIdentifier
  }
  
  private func displayUIData() {
    lblTemp.text = (weatherList?.main?.temp ?? 0.0).ConvertKivToC()
    let date = weatherList?.dt ?? 0.0
    lblHour.text = date.ToFormatedDate(StringConstant.HourMin)
    lblMonth.text = date.ToFormatedDate(StringConstant.Month)
    lblDay.text = date.ToFormatedDate(StringConstant.Day)
    
    imgCloud.downloadImage(getImageUrl())
  }
}
