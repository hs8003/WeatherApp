//
//  HomePageViewModel.swift
//  WeatherApp
//
//  Created by HarshitSharma on 30/06/22.
//

import Foundation
import UIKit

class HomePageViewModel {
  
  func getCityName() -> [String] {
    HomePageDataModel.getCityName()
  }
  
  func getCityCount() -> Int {
    getCityName().count
  }
  
  func getCellHeight() -> Double {
    NumberConstant.NumberFifty
  }
  
  func getCellIdetifier() -> String {
    TableViewCellIdentifier.HomePageTableViewCell.getId()
  }
  
  func getCityName(_ indexPath: IndexPath) -> String {
    getCityName()[indexPath.row]
  }
  
  func GoToDetialViewController(_ indexPath: IndexPath) {
    guard let vc = UIStoryboard(name: StringConstant.main, bundle: nil).instantiateViewController(withIdentifier: ControllerConstant.WeatherDetailsViewController.getId()) as? WeatherDetailsViewController else {return}
    vc.viewModel.cityName = getCityName()[indexPath.row]
    
  }
}
