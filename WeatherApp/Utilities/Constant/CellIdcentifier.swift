//
//  CellIdcentifier.swift
//  WeatherApp
//
//  Created by HarshitSharma on 30/06/22.
//

import Foundation

enum TableViewCellIdentifier {
  
  case HomePageTableViewCell
  
  func getId() -> String {
    return "\(self)"
  }
  
}

enum CollectionViewCellIdentifier {
  
  case WeatherDetailCollectionCell
  
  func getId() -> String {
    return "\(self)"
  }
  
}
