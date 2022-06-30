//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by HarshitSharma on 30/06/22.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
  
  @IBOutlet weak var lblLowTemp: UILabel!
  @IBOutlet weak var lblHighTemp: UILabel!
  @IBOutlet weak var lblCityName: UILabel!
  @IBOutlet weak var ImgStatus: UIImageView!
  @IBOutlet weak var lblStatus: UILabel!
  @IBOutlet weak var lblTemp: UILabel!
  @IBOutlet weak var lblDate: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  
  let viewModel = WeatherDetailsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    callApi()
  }
  
  private func setupUI() {
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  private func callApi() {
    DispatchQueue.global(qos: .background).async {
      self.viewModel.getCityForcastData {
        DispatchQueue.main.async {
          self.collectionView.reloadData()
          self.displayData()
        }
      }
    }
  }
  
  private func displayData() {
    lblCityName.text = viewModel.cityName
    guard let tempData = viewModel.currentWeather?.main else {return}
    lblStatus.text = viewModel.currentWeather?.weather?.first?.main
    lblTemp.text = tempData.temp.ConvertKivToC()
    lblLowTemp.text = tempData.tempMin.ConvertKivToC() + StringConstant.MinTimeIcon
    lblHighTemp.text = tempData.tempMax.ConvertKivToC() + StringConstant.MaxTimeIcon
    lblDate.text = (viewModel.currentWeather?.dt ?? 0.0).ToFormatedDate(StringConstant.MonthDayYear)
    ImgStatus.downloadImage(viewModel.getImageUrl())
  }
}

extension WeatherDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.getNumberOfRowInSection()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.WeatherDetailCollectionCell.getId(), for: indexPath) as? WeatherDetailCollectionCell else {return UICollectionViewCell()}
    cell.weatherList = viewModel.getWeatherObjectFor(indexPath)
    return cell
  }
}
