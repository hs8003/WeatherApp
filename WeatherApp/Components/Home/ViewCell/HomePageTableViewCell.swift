//
//  HomePageTableViewCell.swift
//  WeatherApp
//
//  Created by HarshitSharma on 30/06/22.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {
  
  @IBOutlet weak var lblTitle: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
}
